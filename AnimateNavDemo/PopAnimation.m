//
//  PopAnimation.m
//  整个视图滑动
//
//  Created by qingsong on 15/4/6.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import "PopAnimation.h"

@interface PopAnimation ()

@property (nonatomic,strong)id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    //返回动画执行的时间
    return 0.25;
}

/**
 * transitionContext 可以看做一个工具，用来获取一些列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    /**
     *  获取动画来自的那个控制器
     */
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    /**
     * 获取专场的那个控制器
     */
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /**
     *  转场动画是两个控制器视图时间的动画，需要一个containerView来作为一个舞台，让动画执行。
     */
    UIView * containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    /**
     *  各部门注意了啊，执行动画，让fromVC的视图移动到屏幕的最右侧
     */

    [UIView animateWithDuration:duration animations:^{
        
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        
    } completion:^(BOOL finished) {
       
        /**
         *  当你的动画执行完成，这个防滑必须要调用，否则系统回任务你的其余任何操作都在动画执行的过程中。
         */
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

        _transitionContext = transitionContext;
    //----------------pop动画一-------------------------//
/*
     [UIView beginAnimations:@"View Flip" context:nil];
     [UIView setAnimationDuration:duration];
     [UIView setAnimationDelegate:self];
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:containerView cache:YES];
     [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
     [UIView commitAnimations];//提交UIView动画
     [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    */
    //----------------pop动画二-------------------------//
    /*
     CATransition *tr = [CATransition animation];
     tr.type = @"cube";
     tr.subtype = @"fromLeft";
     tr.duration = duration;
     tr.removedOnCompletion = NO;
     tr.fillMode = kCAFillModeForwards;
     tr.delegate = self;
     [containerView.layer addAnimation:tr forKey:nil];
     [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
     */
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}
@end
