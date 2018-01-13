//
//  ViewController.m
//  chartText
//
//  Created by 张君泽 on 16/7/27.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//  这样可以吗  git 上传东西  地区冲突与经济

#import "ViewController.h"
#import "charts.h"
#import "ZZChart.h"
@interface ViewController ()<ChartDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    charts *chart = [[charts alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100) withDataSource:self andChatStyle:ChartStyleLine];
//    chart.curve = YES;
//    [chart showInView:self.view];
    ZZChart *chart = [ZZChart shareChart];
    chart.xValues = @[@12,@30,@24,@30,@60,@90];
    chart.yValues = @[@0,@40,@0,@20,@10,@200];
    [chart startDrawLine];
    [chart makeScaleWithflot1:200 flot2:160];
    [chart addButtonAtPoint:CGPointMake(100, 100)];
    [self.view addSubview:chart];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSMutableArray *)chatConfigYValue:(charts *)chart {
    NSMutableArray *chartArray = [NSMutableArray arrayWithArray:@[@"2.1",@"3.4",@"10",@"2.5",@"0.5",@"5.0",@"3.0",@"2.8",@"2.3",@"1.0",@"3.6",@"1.7"]];
    return chartArray;
    //    return @[@"100",@"50",@"70",@"30",@"50",@"14",@"5",@"14",@"5",@"14"];
}

- (NSMutableArray *)chatConfigXValue:(charts *)chart {
    NSMutableArray *axisArr = [NSMutableArray arrayWithArray:@[@"10月",@"11月",@"12月",@"1月",@"2月",@"3月",@"4月"]];
    return axisArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
