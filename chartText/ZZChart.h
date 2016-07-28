//
//  ZZChart.h
//  chartText
//
//  Created by 张君泽 on 16/7/28.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZChart : UIView
@property (nonatomic, strong)NSArray *xValues;
@property (nonatomic, strong)NSArray *yValues;
@property (nonatomic, assign)BOOL curve;
+ (ZZChart *)shareChart;
- (void)startDrawLine;
- (void)makeScaleWithflot1:(CGFloat)flot1 flot2:(CGFloat)flot2;
- (void)addButtonAtPoint:(CGPoint)point;
@end
