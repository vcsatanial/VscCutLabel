//
//  UILabel+CutLabel.h
//  VscCutLabel
//
//  Created by tianyan on 2017/12/20.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CutLabelModel;
@interface UILabel (CutLabel) <UIGestureRecognizerDelegate>

/**
 实用此属性,可以直接自适应高度
 */
@property (nonatomic,copy) NSString *adjustText;
/**
 通过计算字符串,获取最后一行的字符串,Range,以及最后一行之前所有的字符串总和

 @param text 需要判断的字符串
 @return 返回一个自定义模型,如果返回的是Nil,说明可以完全展开,不需要增加省略号
 */
-(CutLabelModel *)lastLineModel:(NSString *)text;

/**
 当字符串需要为字符串增加尾字符串,并支持点击

 @param detailStr 增加的为字符串
 @param color 新增字符串的颜色
 @param handler 点击字符串相应的Block
 */
-(void)addDetailStr:(NSString *)detailStr detailColor:(UIColor *)color clickHandler:(void(^)(NSString *allStr,__weak UILabel *selfLabel))handler;

/**
 去掉numOfLine的限制,展示全部内容
 */
-(void)showAllText;
@end
@interface CutLabelModel : NSObject
@property (nonatomic,copy) NSString *beforeStr;
@property (nonatomic,copy) NSString *lastLineStr;
@property (nonatomic,assign) NSRange lastLineRange;
@end
