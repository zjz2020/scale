//
//  ZZChart.m
//  chartText
//
//  Created by 张君泽 on 16/7/28.
//  Copyright © 2016年 CloudEducation. All rights reserved.
//

#import "ZZChart.h"
#import "UIBezierPath+curved.h"
#define yLines 5
//总宽度
#define LineWidth [UIScreen mainScreen].bounds.size.width - 100

@interface ZZChart()
@property (nonatomic, assign)CGFloat xScale;
@property (nonatomic, assign)CGFloat xWidth;
@property (nonatomic, assign)CGFloat yScale;
@property (nonatomic, assign)CGFloat yWidth;
@property (nonatomic, strong)NSMutableArray *points;
@property (nonatomic, weak)UILabel *lable;
@property (nonatomic, assign)CGFloat title;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)CGFloat angle;
@end

@implementation ZZChart
- (NSArray *)points {
    if (!_points) {
        self.points = [NSMutableArray new];
    }
    return _points;
}


+ (ZZChart *)shareChart{
    ZZChart *chart = [[ZZChart alloc] initWithFrame:CGRectMake(50, 50,LineWidth, 200)];
    chart.title = 0;
    return chart;
}
- (void)startDrawLine{
//    [self calculateXandYscale];
//    [self drawHorizontalAndVct];
//    [self writLineAtView];
    [self makeRect];
}
//画坐标系
- (void)drawHorizontalAndVct{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    void(^addShapeLayer)() = ^(){
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        shapeLayer.lineWidth = 0.5f;
        [self.layer addSublayer:shapeLayer];
    };
    for (NSInteger i = 0; i < yLines; i ++) {//x
        [path moveToPoint:CGPointMake(0, 50 *i)];
        [path addLineToPoint:CGPointMake(LineWidth,  50 *i)];
        addShapeLayer();
        //添加y方向的label
        if (i < yLines -1) {
            [self addLabelAtXWithPoint:CGPointMake(-50, 50 *i - 15) width:50 text:_yWidth *(yLines - i - 1)];
        }
        if (i == yLines - 1) {
            for (NSInteger j = 1; j <= 5; j ++) {
                CGFloat widthLittle = (LineWidth)/5;
                [path moveToPoint:CGPointMake(widthLittle * j, 50 *i)];
                [path addLineToPoint:CGPointMake(widthLittle *j, 50 *i - 10)];
                addShapeLayer();
                //添加X方向的label
                [self addLabelAtXWithPoint:CGPointMake(widthLittle *(j - 1), 50 *i) width:widthLittle text:_xWidth *j];
            }
        }
    }
    //y
    [path moveToPoint:CGPointMake(0, -20)];
    [path addLineToPoint:CGPointMake(0, 200)];
    addShapeLayer();
}
//计算比例
- (void)calculateXandYscale{
    //x
    CGFloat maxX = 0;
    for (NSInteger i = 0 ; i < self.xValues.count; i ++) {
        CGFloat x = [self.xValues[i] floatValue];
        maxX = (maxX > x ? maxX:x);
    }
    _xScale = 200/maxX;
    _xWidth = maxX/5;
    //y
    CGFloat maxY = 0;
    for (NSInteger i = 0 ; i < self.yValues.count; i ++) {
        CGFloat x = [self.yValues[i] floatValue];
        maxY = (maxY > x ? maxY:x);
    }
    _yScale = 200/maxY;
    _yWidth = maxY/4;
    NSLog(@"%f  %f  ",_xScale,_yScale);
    [self makePoints];
}
//转换坐标点
- (void)makePoints{
    for (NSInteger i = 0; i < self.xValues.count; i ++) {
        CGFloat x = [self.xValues[i] floatValue] *_xScale;
        CGFloat y =  200 - [self.yValues[i] floatValue]*_yScale;
        CGPoint point = CGPointMake(x, y);
        [self.points addObject:[NSValue valueWithCGPoint:point]];
    }
}
//添加label
- (void)addLabelAtXWithPoint:(CGPoint) point  width:(CGFloat)width text:(CGFloat)text{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(point.x, point.y, width, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor cyanColor];
    lable.text = [NSString stringWithFormat:@"%.1f",text];
    [self addSubview:lable];
}
//画直线
- (void)writLineAtView{
    UIBezierPath *path = [UIBezierPath bezierPath];
   
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    path.lineCapStyle = kCGLineCapRound;//线条拐角
    path.lineJoinStyle = kCGLineCapRound;//终点处理
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.lineJoin = kCALineJoinRound;
    for (NSInteger i = 0; i < self.points.count; i ++) {
        if (i == 0) {
            [path moveToPoint:[_points[i] CGPointValue]];
        }
        if (i < _points.count - 1) {
            [path addLineToPoint:[_points[i + 1] CGPointValue]];
        }
        [self writPointAtPoint:[_points[i] CGPointValue]];
    }
    path = [path smoothedPathWithGranularity:10];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    [self.layer addSublayer:shapeLayer];
    //动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.points.count * 0.5f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    pathAnimation.autoreverses = NO;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    shapeLayer.strokeEnd = 1.f;
}
//画点
- (void)writPointAtPoint:(CGPoint)point{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    view.center = point;
    NSLog(@"%@",NSStringFromCGPoint(point));
    view.backgroundColor = [UIColor redColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    [self addSubview:view];
}
//画矩形
- (void)makeRect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineWidth = 3;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    
    for (NSInteger i = 0; i < self.points.count; i ++) {
            [path moveToPoint:[_points[i] CGPointValue]];
        if (i < _points.count - 1) {
            [path addLineToPoint:[_points[i + 1] CGPointValue]];
        }
        [self writPointAtPoint:[_points[i] CGPointValue]];
    }
    shapeLayer.path = path.CGPath;
    //动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.points.count * 0.5f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    pathAnimation.autoreverses = NO;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    shapeLayer.strokeEnd = 1.f;

}
- (void)makeScaleWithflot1:(CGFloat)flot1 flot2:(CGFloat)flot2{
    CGPoint point = CGPointMake(200, 400);
    UIBezierPath * aPath = [UIBezierPath bezierPathWithArcCenter:point
                                                         radius:50
                                                     startAngle:0
                                                       endAngle:(M_PI *2 * (flot2/flot1))
                                                      clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineWidth = 50;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = aPath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    [self addlaberAtPoint:point width:50 text:flot2/flot1];
    //动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    pathAnimation.autoreverses = NO;
    [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    shapeLayer.strokeEnd = 1.f;
    


}
- (void)addlaberAtPoint:(CGPoint)point width:(CGFloat)width text:(CGFloat)text{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    //添加定时器
    _title = 0;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(makeTitleChange) userInfo:nil repeats:YES];
    [timer fire];
    self.timer = timer;
    lable.center = point;
    self.lable = lable;
    lable.layer.masksToBounds = YES;
    lable.layer.cornerRadius = width/2;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor redColor];
    lable.text = [NSString stringWithFormat:@"%.1f",text];
    [self addSubview:lable];

}
- (void)makeTitleChange{
    _title += 0.1;
    NSLog(@"%.1f",_title);
    [_lable setText:[NSString stringWithFormat:@"%.1f",_title]];
    if ([_lable.text isEqualToString:@"0.8"]) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)addButtonAtPoint:(CGPoint)point{
    _angle = 0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 100;
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(0, 0, 100, 100);
    _title = 0;
    [button addTarget:self action:@selector(makeTitleChange) forControlEvents:UIControlEventTouchUpInside];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(makeBtnCricleAtPoint:) userInfo:nil repeats:YES];
    [timer fire];
    [self addSubview:button];
}
- (void)makeBtnCricleAtPoint:(CGPoint)point{
    _angle += 30;
    UIButton *button = [self viewWithTag:100];
    CGFloat x = 100 *cos(M_PI *(_angle/180));
    CGFloat y = 100 *sin(M_PI *(_angle/180));
    button.center = CGPointMake(50 + x, 50 + y);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
