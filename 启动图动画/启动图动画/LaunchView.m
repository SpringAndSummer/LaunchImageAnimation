//
//  LaunchView.m
//  启动图动画
//
//  Created by 曹相召 on 2017/6/12.
//  Copyright © 2017年 曹相召. All rights reserved.
//

#import "LaunchView.h"
@interface LaunchView()
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation LaunchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"chengshi"];
        [self addSubview:self.imageView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
