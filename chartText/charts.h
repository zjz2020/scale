//
//  charts.h
//  chartText
//
//  Created by 张君泽 on 16/7/28.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class charts;
typedef NS_ENUM(NSInteger, ChartStyle) {
    ChartStyleAll = 0,
    ChartStyleLine =1,
    ChartStyleBar = 2
};

@protocol ChartDataSource <NSObject>

@required
//configuration y-axis
- (NSMutableArray *)chatConfigYValue:(charts *)chart;
//configuration x-axis
- (NSMutableArray *)chatConfigXValue:(charts *)chart;

@end

@interface charts : UIView
/**
 *  @author wqp, 16-05-25 17:20:30
 *
 *  line  是否曲线
 */
@property (nonatomic, assign) BOOL curve;

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ChartDataSource>)dataSource andChatStyle:(ChartStyle)chartStyle;

- (void)showInView:(UIView *)view;

@end
