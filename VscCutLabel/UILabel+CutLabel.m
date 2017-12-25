//
//  UILabel+CutLabel.m
//  VscCutLabel
//
//  Created by tianyan on 2017/12/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "UILabel+CutLabel.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>

static char kAllText;
static char kClickBlock;
static char kDetailStr;
static char kLastLineStr;
NSString *const kTokenString = @"\u2026";

@implementation UILabel (CutLabel)
-(NSString *)allText{
	return objc_getAssociatedObject(self, &kAllText);
}
-(void)setAllText:(NSString *)allText{
	objc_setAssociatedObject(self, &kAllText, allText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void(^)(NSString *allStr,__weak UILabel *selfLabel))clickBlock{
	return objc_getAssociatedObject(self, &kClickBlock);
}
-(void)setClickBlock:(void(^)(NSString *allStr,__weak UILabel *selfLabel))clickBlock{
	objc_setAssociatedObject(self, &kClickBlock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)detailStr{
	return objc_getAssociatedObject(self, &kDetailStr);
}
-(void)setDetailStr:(NSString *)detailStr{
	objc_setAssociatedObject(self, &kDetailStr, detailStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)lastLineStr{
	return objc_getAssociatedObject(self, &kLastLineStr);
}
-(void)setLastLineStr:(NSString *)lastLineStr{
	objc_setAssociatedObject(self, &kLastLineStr, lastLineStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)adjustText{
	return [self allText];
}
-(void)setAdjustText:(NSString *)adjustText{
	self.text = adjustText;
	CGFloat fitHeight = [self calHeightWithStr:adjustText];
	CGFloat numLineHeight = self.numberOfLines == 0 ? MAXFLOAT : self.numberOfLines * self.font.lineHeight;
	CGFloat realHeight = MIN(fitHeight, numLineHeight);
	CGRect frame = self.frame;
	frame.size.height = realHeight;
	self.frame = frame;
}
-(CutLabelModel *)lastLineModel:(NSString *)text{
	if (!text) {
		return nil;
	}
	NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:self.font}];
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, CGRectMake(0, 0, CGRectGetWidth(self.bounds), MAXFLOAT));
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributed);
	CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, NULL);
	
	CFArrayRef lines = CTFrameGetLines(ctFrame);
	CFIndex lineCount = CFArrayGetCount(lines);
	if (self.numberOfLines == 0 || lineCount <= self.numberOfLines) {
		return nil;
	}
	CTLineRef line = CFArrayGetValueAtIndex(lines, self.numberOfLines - 1);
	CFRange lastLineRange = CTLineGetStringRange(line);
	CutLabelModel *model = [[CutLabelModel alloc] init];
	model.beforeStr = [text substringToIndex:lastLineRange.location];
	model.lastLineRange = NSMakeRange(lastLineRange.location, lastLineRange.length);
	model.lastLineStr = [text substringWithRange:model.lastLineRange];
	return model;
}
-(void)addDetailStr:(NSString *)detailStr detailColor:(UIColor *)color clickHandler:(void (^)(NSString *,__weak UILabel *selfLabel))handler{
	CutLabelModel *model = [self lastLineModel:self.text];
	if (detailStr.length == 0 || !color || !model) {
		return;
	}
	[self setDetailStr:detailStr];
	[self setAllText:self.text];
	[self setClickBlock:handler];
	self.userInteractionEnabled = YES;
	NSUInteger lastLineLength = model.lastLineRange.length;
	int length = 0;
	CGFloat detailWidth = [self calWidthWithStr:detailStr];
	CGFloat dotWidth = [self calWidthWithStr:kTokenString];
	while ([self calWidthWithStr:[model.lastLineStr substringToIndex:lastLineLength - length]] + dotWidth + detailWidth + 4 > self.frame.size.width) {
		length++;
	}
	NSString *subStr = [self.text substringToIndex:model.lastLineRange.location + model.lastLineRange.length - length];
	NSString *addDotStr = [subStr stringByAppendingString:kTokenString];
	
	NSString *lastLine = [self.text substringWithRange:NSMakeRange(model.lastLineRange.location, model.lastLineRange.length - length)];
	[self setLastLineStr:lastLine];
	
	self.text = addDotStr;
	NSAttributedString *detailAtt = [[NSAttributedString alloc] initWithString:detailStr attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:self.font}];
	NSMutableAttributedString *attAddStr = self.attributedText.mutableCopy;
	[attAddStr appendAttributedString:detailAtt];
	self.attributedText = attAddStr.copy;
}
-(CGFloat)calWidthWithStr:(NSString *)str{
	CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
									options:NSStringDrawingUsesLineFragmentOrigin
								 attributes:@{NSFontAttributeName : self.font}
									context:NULL].size;
	return size.width;
}
-(CGFloat)calHeightWithStr:(NSString *)str{
	CGSize size = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
									options:NSStringDrawingUsesLineFragmentOrigin
								 attributes:@{NSFontAttributeName : self.font}
									context:NULL].size;
	return size.height;
}
-(void)showAllText{
	self.text = [self allText];
	self.numberOfLines = 0;
	CGFloat height = [self calHeightWithStr:self.text];
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	[super touchesBegan:touches withEvent:event];
	if (![self clickBlock]) {
		return;
	}
	CGFloat lineHeight = self.font.lineHeight;
	NSInteger count = self.numberOfLines - 1;
	CGFloat detailWidth = [self calWidthWithStr:[self detailStr]] + 15;
	NSString *lineStr = [self lastLineStr];
	CGFloat detailX = [self calWidthWithStr:lineStr];
	CGRect rect = CGRectMake(detailX, count * lineHeight - 5, detailWidth, lineHeight + 5);
	if (CGRectContainsPoint(rect, point)) {
		__weak UILabel *wl = self;
		self.clickBlock([self allText],wl);
	}
}
@end
@implementation CutLabelModel
@end

