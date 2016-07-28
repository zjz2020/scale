//
//  allChart.h
//  chartText
//
//  Created by 张君泽 on 16/7/28.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
static const CGFloat chartAllStartX = 50.f;//起始位置
static const CGFloat chartAllAxisSpanX = 50.f;//X轴跨度
static const CGFloat chartAllAxisSpanY = 50.f;//Y轴跨度
@interface allChart : UIView

@property (nonatomic, strong) NSArray * xValues;
@property (nonatomic, strong) NSArray * yValues;
@property (nonatomic, assign) CGFloat yMax;
@property (nonatomic, assign) BOOL curve;//曲线的判断标记

- (void)startDrawBarAndLines;
@end
