//
//  ViewController.h
//  启动图动画
//
//  Created by 曹相召 on 2017/6/12.
//  Copyright © 2017年 曹相召. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AnimationEnd)(void);
@interface ViewController : UIViewController
@property (nonatomic, copy) AnimationEnd animationEnd;
@end

