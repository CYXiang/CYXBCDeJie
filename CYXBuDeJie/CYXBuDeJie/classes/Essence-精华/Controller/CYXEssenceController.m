//
//  CYXEssenceController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXEssenceController.h"
#import "CYXRecommandTagViewController.h"


@interface CYXEssenceController ()

@end

@implementation CYXEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CYXCommonBgColor;
    
    // 设置标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    
    // 设置左上角按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimageName:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(mainBtnClick) ];
    

}



- (void)mainBtnClick{
    
    CYXRecommandTagViewController *tag = [[CYXRecommandTagViewController alloc]init];

    [self.navigationController pushViewController:tag animated:YES];
}

@end
