//
//  Nav.m
//  整个视图滑动
//
//  Created by qingsong on 15/4/6.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import "Nav.h"
#import "NavigationInteractiveTransition.h"

@interface Nav ()<UIGestureRecognizerDelegate>

@property (nonatomic,weak) UIPanGestureRecognizer *popRecognizer;

/**
 *  方法一不需要的变量
 */
@property (nonatomic,strong) NavigationInteractiveTransition * navT;
@end

@implementation Nav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGestureRecognizer * gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    
    UIView * gesrureView = gesture.view;
    
    UIPanGestureRecognizer * popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gesrureView addGestureRecognizer:popRecognizer];

    self.navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:self.navT action:@selector(handleControllerPop:)];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    /**
     *  这里有两个条件不允许手势执行，1.当前控制器为跟试图；2.如果push,pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
