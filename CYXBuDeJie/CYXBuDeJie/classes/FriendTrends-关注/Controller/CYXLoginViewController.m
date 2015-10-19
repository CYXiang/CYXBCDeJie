//
//  CYXLoginViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/2.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXLoginViewController.h"

@interface CYXLoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation CYXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;
}

- (IBAction)loginOrRegister:(UIButton *)button {
    
    
    
    // 修改按钮的选中状态
    button.selected = !button.isSelected;
    
    // 修改约束
    if (self.leftMargin.constant) {
        self.leftMargin.constant = 0;
    } else {
        self.leftMargin.constant = - self.view.width;
    }
    
    // 执行动画
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    // 退出键盘
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)closeLoginView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
