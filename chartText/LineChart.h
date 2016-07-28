//
//  LineChart.h
//  chartText
//
//  Created by 张君泽 on 16/7/27.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
static const CGFloat chartLineStartX = 50.f;
static const CGFloat chartLineAxisSpanX = 50.f;
static const CGFloat chartLineAxisSpanY = 50.f;
@interface LineChart : UIView
@property (nonatomic, strong) NSArray * xValues;
@property (nonatomic, strong) NSArray * yValues;
@property (nonatomic, assign) CGFloat yMax;
@property (nonatomic, assign) BOOL curve;

- (void)startDrawLine;
@end
