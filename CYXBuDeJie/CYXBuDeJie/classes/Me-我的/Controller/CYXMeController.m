//
//  CYXMeController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXMeController.h"
#import "CYXSettingViewController.h"

@interface CYXMeController ()

@end

@implementation CYXMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置标题
    self.navigationItem.title = @"我的";

    // 设置右上角的按钮
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithimageName:@"mine-moon-icon" highlightImage:@"mine-sun-icon-click" target:self action:@selector(moonBtnClick)];
    
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithimageName:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(setBtnClick)];

    
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    

}

- (void)moonBtnClick{
    CYXLogFuc;
}

/**
 *  设置按钮的点击事件
 */
- (void)setBtnClick{
    
    CYXSettingViewController *setVC = [[CYXSettingViewController alloc]init];
    
    [self.navigationController pushViewController:setVC animated:YES];

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
