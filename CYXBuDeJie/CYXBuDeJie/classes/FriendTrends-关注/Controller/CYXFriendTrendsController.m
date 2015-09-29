//
//  CYXFriendTrendsController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXFriendTrendsController.h"

@interface CYXFriendTrendsController ()

@end

@implementation CYXFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimageName:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(leftBarButtonClick)];
    
}

- (void)leftBarButtonClick{
    CYXLogFuc;
}

@end
