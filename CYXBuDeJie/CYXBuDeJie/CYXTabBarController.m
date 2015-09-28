//
//  CYXTabBarController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTabBarController.h"
#import "CYXEssenceController.h"
#import "CYXFriendTrendsController.h"
#import "CYXNewController.h"
#import "CYXMeController.h"

@interface CYXTabBarController ()

@end

@implementation CYXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一设置Item的文字属性
    [self setUpItemTextAttrs];
    // 添加所以子控制器
    [self setUpAllChildViewControllers];
    
    
    
}

- (void)setUpItemTextAttrs{
    //统一设置Item文字的属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}


- (void)setUpAllChildViewControllers{
    CYXEssenceController *essence = [[CYXEssenceController alloc]init];
    [self setUpOneViewController:essence title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    CYXNewController *new = [[CYXNewController alloc]init];
    [self setUpOneViewController:new title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    CYXFriendTrendsController *friendTrends = [[CYXFriendTrendsController alloc]init];
    [self setUpOneViewController:friendTrends title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    CYXMeController *me = [[CYXMeController alloc]init];
    [self setUpOneViewController:me title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
}


//设置一个子控制器
- (void)setUpOneViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    vc.view.backgroundColor = [UIColor grayColor];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:vc];
}

@end
