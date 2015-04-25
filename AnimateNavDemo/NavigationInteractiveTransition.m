//
//  NavigationInteractiveTransition.m
//  整个视图滑动
//
//  Created by qingsong on 15/4/6.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import "NavigationInteractiveTransition.h"
#import "PopAnimation.h"

@interface NavigationInteractiveTransition ()
@property (nonatomic,weak)UINavigationController * vc;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition * interactivePopTransition;
@end

@implementation NavigationInteractiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        self.vc = (UINavigationController *)vc;
        self.vc.delegate = self;
    }
    return self;
}
/**
 *   把用户的每次pan手势操作作为一次pop动画的执行
 */
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer
{
    /**
     *  interactivePopTransition就是我们说的方法2返回的对象，我们需要更新它的进度来控制pop动画的流程，我们用手指在视图中的位置与试图宽度比例作为它的进度。
     */
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    NSLog(@"progress        %f",progress);
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        /**
         *  手势开始了，新建一个控制对象
         */
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        /**
         *  告诉控制器开始执行pop动画
         */
        [self.vc popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        /**
         *  更新手势的完成进度
         */
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        /**
         *  手势结束时如果进度大于一半，要么pop，否则重新来过
         */
        
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else
        {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    /**
     *  方法1中判断如果当前执行的pop操作，就放回我们自定义的pop动画对象
     */
    if (operation == UINavigationControllerOperationPop) {
        return [[PopAnimation alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    /**
     *  方法2会传给你当前的动画对象animationController,判断如果是我们自定义的pop动画对象，那么就返回interactivePopTransition来监控动画完成度。
     */
    if ([animationController isKindOfClass:[PopAnimation class]]) {
        return self.interactivePopTransition;
    }
    return nil;
}
@end
