//
//  ViewController.m
//  启动图动画
//
//  Created by 曹相召 on 2017/6/12.
//  Copyright © 2017年 曹相召. All rights reserved.
//

#import "ViewController.h"
#import "LaunchView.h"
//判断目前机型的宏定义
#define UI_IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IPHONE4      (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define IPHONE5      (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IPHONE6      (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IPHONE6P     (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations

@interface ViewController ()
@property (nonatomic, strong) UIImageView *backGround;//背景图,与启动图保持一致,做一个假象
@property (nonatomic, strong) CAShapeLayer *maskLayer;//
@property (nonatomic, strong) LaunchView *launchView;//需要展示动画的部分,在这里我封装一下,也可以不封装,根据需求调节
@property (nonatomic, assign) NSInteger count;//计数器计数值
@property (nonatomic, strong) NSTimer *timer;//计时器
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.背景图,根据机型生成自定义启动页面的背景图(假象)(与启动图保持高度一致)
    self.backGround = [[UIImageView alloc] initWithImage:[self getBackGroundImage]];
    [self.view addSubview:self.backGround];
    
    //2.构建需要动画展示的视图
    CGFloat launchViewWidth = 263;
    CGFloat launchViewHeight = 135;
    self.launchView = [[LaunchView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - launchViewWidth) * 0.5, 100, launchViewWidth, launchViewHeight)];
    self.launchView.alpha = 0;//初始化不透明度为0,防止刚加入的瞬间,闪动
    
    //3.初始化CAShapeLayer
    self.maskLayer = [[CAShapeLayer alloc] init];
    self.maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    //4.初始化计数器值并构建计数器
    self.count = 1;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    [self.view addSubview:self.launchView];
}
- (void)animation
{
    //5.视图不透明度改为1
    self.launchView.alpha = 1;
    self.count = self.count + 2;
    
    //6.根据launchView的圆心,去生成一个贝塞尔曲线,并根据贝塞尔曲线的路径生成CAShapeLayer,并将其赋值给launchView的CALayer的蒙层(mask图层定义了父图层的部分可见区域)
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.launchView.center.x - self.launchView.frame.origin.x, self.launchView.center.y - self.launchView.frame.origin.y) radius:self.count startAngle:0 endAngle:2 * M_PI clockwise:YES];
    self.maskLayer.path = path.CGPath;
    self.launchView.layer.mask = self.maskLayer;
    
    if(self.count > self.view.frame.size.width * 0.5 + 20)
    {
        //到达限定值之后，定时器销毁，调用回调函数
        [self.timer invalidate];
        self.timer = nil;
        
        if(self.animationEnd){
            self.animationEnd();
        }
    }
}
- (UIImage *)getBackGroundImage
{
    NSString *launchImageName = @"LaunchImage";
    if (IPHONE5)
    {
        launchImageName = @"LaunchImage-568h";
    }
    else if(IPHONE6)
    {
        launchImageName = @"LaunchImage-800-667h";
    }
    else if (IPHONE6P)
    {
        launchImageName = @"LaunchImage-800-Portrait-736h";
    }
    return [UIImage imageNamed:launchImageName];
}
@end
