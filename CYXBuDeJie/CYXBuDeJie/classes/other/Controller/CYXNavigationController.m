//
//  CYXNavigationController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/30.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXNavigationController.h"

@interface CYXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CYXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置pop手势的代理
    self.interactivePopGestureRecognizer.delegate = self;
    
}

/**
 *  重写这个方法的目的是：为了拦截整个push过程，拿到所有push进来的控制器
 *
 *  @param viewController 当前push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(blackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮内容内边距
        button.contentEdgeInsets = UIEdgeInsetsMake(0,-10, 0, 0);
        // 自适应大小
        [button sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
 
    [super pushViewController:viewController animated:animated];
}

- (void)blackBtnClick{
    
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>

/**
 *  这个代理方法的作用：决定pop手势是否有效
 *
 *  @return YES：手势有效  NO：手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.viewControllers.count == 1) {
//        return NO;
//    }else{
//        return YES;
//    }
    
    return self.viewControllers.count > 1;
}

@end
