//
//  NavigationInteractiveTransition.h
//  整个视图滑动
//
//  Created by qingsong on 15/4/6.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//专门处理交互对象

#import <UIKit/UIKit.h>

@class UIViewController, UIPercentDrivenInteractiveTransition,UINavigationController;

@interface NavigationInteractiveTransition : NSObject
<UINavigationControllerDelegate>

- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;
- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;
@end