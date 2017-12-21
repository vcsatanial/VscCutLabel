//
//  ViewController.m
//  VscCutLabel
//
//  Created by tianyan on 2017/12/18.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+CutLabel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UILabel *cut = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 150, 40)];
	cut.numberOfLines = 6;
	cut.backgroundColor = [UIColor greenColor];
	cut.adjustText = @"xygh一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890";
	[self.view addSubview:cut];
	[cut addDetailStr:@"展开全文" detailColor:[UIColor redColor] clickHandler:^(NSString *allStr,__weak UILabel *selfLabel) {
		NSLog(@"%@",allStr);
	}];

	UILabel *cut1 = [[UILabel alloc] initWithFrame:CGRectMake(210, 50, 150, 0)];
	cut1.numberOfLines = 6;
	cut1.backgroundColor = [UIColor greenColor];
	cut1.adjustText = @"xygh一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890一二三四五六七八九十1234567890";
	[cut1 addDetailStr:@"详情" detailColor:[UIColor redColor] clickHandler:^(NSString *allStr,__weak UILabel *selfLabel) {
		NSLog(@"%@",allStr);
	}];
	[self.view addSubview:cut1];
	
	UILabel *cut2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 150, 40)];
	cut2.numberOfLines = 5;
	cut2.backgroundColor = [UIColor greenColor];
	cut2.adjustText = @"居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃";
	[cut2 addDetailStr:@"展开全文" detailColor:[UIColor redColor] clickHandler:^(NSString *allStr,__weak UILabel *selfLabel) {
		[selfLabel showAllText];
	}];
	[self.view addSubview:cut2];
	
	UILabel *cut3 = [[UILabel alloc] initWithFrame:CGRectMake(210, 200, 150, 238)];
	cut3.numberOfLines = 0;
	cut3.backgroundColor = [UIColor greenColor];
	cut3.adjustText = @"居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃居客都费劲埃";
	[cut addDetailStr:@"展开全文" detailColor:[UIColor redColor] clickHandler:^(NSString *allStr,__weak UILabel *selfLabel) {
		NSLog(@"%@",allStr);
	}];
	[self.view addSubview:cut3];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
