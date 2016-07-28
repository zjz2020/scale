//
//  chartBar.h
//  chartText
//
//  Created by 张君泽 on 16/7/27.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
static const CGFloat chartBarStartX = 50.f;
static const CGFloat chartBarAxisSpanX = 50.f;
static const CGFloat chartBarAxisSpanY = 50.f;
@interface chartBar : UIView
@property (nonatomic, strong) NSArray * xValues;
@property (nonatomic, strong) NSArray * yValues;

@property (nonatomic, assign) CGFloat yMax;
//开始绘制图表
- (void)startDrawBar;
@end
