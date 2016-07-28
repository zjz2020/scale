//
//  charts.m
//  chartText
//
//  Created by 张君泽 on 16/7/28.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import "charts.h"
#import "allChart.h"
#import "LineChart.h"
#import "chartBar.h"

@interface charts ()
@property (nonatomic, strong) UIView *MyView;//also set ScrollerView
@property (nonatomic, assign) ChartStyle *chartStyle;//chart style
@property (nonatomic, weak) id<ChartDataSource>dataSource;//datasource
@property (nonatomic, strong) allChart *chartAll;
@property (nonatomic, strong) LineChart *chartLine;
@property (nonatomic, strong) chartBar *chartBar;
@property (nonatomic, strong) UIScrollView *ScrollView;//to line
@end

@implementation charts
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ChartDataSource>)dataSource andChatStyle:(ChartStyle )chartStyle{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = dataSource;
        self.chartStyle = (ChartStyle *)chartStyle;
        self.curve = NO;
    }
    return self;
}

- (void)startDraw{
    if (_chartStyle == ChartStyleAll) {
        
        self.MyView.frame = self.bounds;
        self.chartAll = [[allChart alloc] initWithFrame:self.bounds];
        [self.MyView addSubview:self.chartAll];
        
        NSMutableArray * yArray = [NSMutableArray arrayWithArray:[self.dataSource chatConfigYValue:self]];
        NSArray * xArray = [self.dataSource chatConfigXValue:self];
        NSInteger count = xArray.count - yArray.count;
        if (count > 0) {
            
            for (NSInteger i = 0; i < count; i++) {
                [yArray addObject:@(0).stringValue];
                
            }
        }
        
        //sort an array
        //        NSArray * sourtArray = [yArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //
        //            return [obj2 floatValue] > [obj1 floatValue];
        //        }];
        
        self.chartAll.yMax = 5.1;
        self.chartAll.curve = self.curve;
        [self.chartAll setXValues:xArray];
        [self.chartAll setYValues:yArray];
        
        [self.chartAll startDrawBarAndLines];
        
        CGRect frame = self.chartAll.frame;
        frame.size.width = chartAllStartX + xArray.count * chartAllAxisSpanX;
        self.chartAll.frame = frame;
        
    }else if(_chartStyle == (ChartStyle *)ChartStyleLine){
        
        self.ScrollView.frame = self.bounds;
        self.chartLine = [[LineChart alloc] initWithFrame:self.bounds];
        [self.ScrollView addSubview:self.chartLine];
        
        NSMutableArray * yArray = [NSMutableArray arrayWithArray:[self.dataSource chatConfigYValue:self]];
        NSArray * xArray = [self.dataSource chatConfigXValue:self];
        NSInteger count = xArray.count - yArray.count;
        if (count > 0) {
            for (NSInteger i = 0; i < count; i++) {
                [yArray addObject:@(0).stringValue];
                
            }
        }
        self.chartLine.yMax = 4.1;
        self.chartLine.curve = self.curve;
        [self.chartLine setXValues:xArray];
        [self.chartLine setYValues:yArray];
        [self.chartLine startDrawLine];
        
        self.ScrollView.contentSize = CGSizeMake(chartLineAxisSpanX * xArray.count + chartLineStartX, 0);
        CGRect frame = self.chartLine.frame;
        frame.size.width = xArray.count * chartAllAxisSpanX;
        self.chartLine.frame = frame;
        
    } else {
        self.MyView.frame = self.bounds;
        self.chartBar = [[chartBar alloc] initWithFrame:self.bounds];
        [self.MyView addSubview:self.chartBar];
        
        NSMutableArray * yArray = [NSMutableArray arrayWithArray:[self.dataSource chatConfigYValue:self]];
        NSArray * xArray = [self.dataSource chatConfigXValue:self];
        NSInteger count = xArray.count - yArray.count;
        if (count > 0) {
            
            for (NSInteger i = 0; i < count; i++) {
                [yArray addObject:@(0).stringValue];
                
            }
        }
        
        self.chartBar.yMax = 5.1;
        [self.chartBar setXValues:xArray];
        [self.chartBar setYValues:yArray];
        [self.chartBar startDrawBar];
        
        CGRect frame = self.chartBar.frame;
        frame.size.width =  xArray.count * chartAllAxisSpanX;
        self.chartBar.frame = frame;
    }
    
}

- (void)showInView:(UIView *)view{
    [self startDraw];
    [view addSubview:self];
}

- (UIView *)MyView {
    if (!_MyView) {
        _MyView = [[UIScrollView alloc] init];
        [self addSubview:_MyView];
    }
    return _MyView;
}

- (UIScrollView *)ScrollView {
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc] init];
        [self addSubview:_ScrollView];
    }
    return _ScrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
