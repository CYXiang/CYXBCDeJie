//
//  CYXNewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXNewController.h"

@interface CYXNewController ()

@end

@implementation CYXNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CYXCommonBgColor;

    
    // 设置标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
    // 设置左上角按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimageName:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnClick) ];

}

- (void)leftBtnClick{
    CYXLogFuc;
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
