//
//  CYXTabBarController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTabBarController.h"
#import "CYXEssenceController.h"
#import "CYXNewController.h"
#import "CYXMeController.h"
#import "CYXTabBar.h"
#import "CYXTestViewController.h"

#import "CYXNavigationController.h"

@interface CYXTabBarController ()

@end

@implementation CYXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 统一设置Item的文字属性
    [self setUpItemTextAttrs];
    
    // 添加所以子控制器
    [self setUpAllChildViewControllers];
    
    // 设置tabBar
    [self setUpTabBar];
    
}

/**
 *  设置tabBar
 */
- (void)setUpTabBar{
    
    [self setValue:[[CYXTabBar alloc]init] forKeyPath:@"tabBar"];

}

/**
 *  统一设置Item文字的属性
 */
- (void)setUpItemTextAttrs{
    // 统一设置Item文字的属性
    // 属性末尾有这个宏，UI_APPEARANCE_SELECTOR。都可以全局统一设置其属性，并在程序的每一处都显示
    // 普通状态下
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    // 选中状态下
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

/**
 *  添加所有子控制器
 */
- (void)setUpAllChildViewControllers{
    
    CYXLogFuc;
    

    
//    [self setUpOneViewController:[[CYXNavigationController alloc]initWithRootViewController:[[CYXFriendTrendsController alloc]init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    // 添加第一个子控制器
    [self setUpOneViewController:[[CYXNavigationController alloc]initWithRootViewController:[[CYXEssenceController alloc]init]] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    // 添加第二个子控制器
    [self setUpOneViewController:[[CYXNavigationController alloc]initWithRootViewController:[[CYXNewController alloc]init]] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    


    // 添加第四个子控制器
    [self setUpOneViewController:[[CYXNavigationController alloc]initWithRootViewController:[[CYXMeController alloc]init]]  title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
    CYXTestViewController *vc = [UIStoryboard storyboardWithName:@"CYXTestViewController" bundle:nil].instantiateInitialViewController;
    
     [self setUpOneViewController:[[CYXNavigationController alloc]initWithRootViewController:vc] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    // 添加第三个子控制器
//    CYXFriendTrendsController * friendTrends = [UIStoryboard storyboardWithName:NSStringFromClass([CYXFriendTrendsController class]) bundle:nil].instantiateInitialViewController;
//    
//    
//    [self setUpOneViewController:[[CYXNavigationController alloc]initWithRootViewController:friendTrends] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    
}


/**
 *  添加一个子控制器
 *
 *  @param vc          控制器
 *  @param title       标题
 *  @param image       普通图片
 *  @param selectImage 选中的图片
 */
- (void)setUpOneViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    CYXLog(@"%s", __func__);
//    vc.view.backgroundColor = CYXRandomColor;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [self addChildViewController:vc];
}

@end
