//
//  CYXTestViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/2.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTestViewController.h"

@interface CYXTestViewController ()

@end

@implementation CYXTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CYXCommonBgColor;
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimageName:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(leftBarButtonClick)];
}

- (void)leftBarButtonClick{
    CYXLogFuc;
}


/**
 *  这个方法的作用是让其他控制器回到当前控制器
 *  必备格式：1.IBAction 2.有1个UIStoryboardSegue *参数
 *
 *  @param segue
 */
- (IBAction)backToFriendTrendsViewController:(UIStoryboardSegue *)segue{
    
    CYXLog(@"从%@控制器来的",segue.sourceViewController);
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
