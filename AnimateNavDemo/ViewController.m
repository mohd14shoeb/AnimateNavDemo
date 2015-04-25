//
//  ViewController.m
//  AnimateNavDemo
//
//  Created by qingsong on 15/4/25.
//  Copyright (c) 2015年 qingsong. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"翻滚吧" style:UIBarButtonItemStylePlain target:self action:@selector(gotoSecondVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)gotoSecondVC
{
    SecondViewController * secondViewCon = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewCon animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
