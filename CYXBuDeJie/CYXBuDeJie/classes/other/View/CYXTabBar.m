//
//  CYXTabBar.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTabBar.h"

@interface CYXTabBar ()

/** 中间的按钮 */
@property (strong, nonatomic) UIButton * sentBtn;

@end

@implementation CYXTabBar

/**
 *  添加子控件
 */
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        UIButton *sendBtn = [[UIButton alloc]init];
        [sendBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [sendBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [sendBtn sizeToFit];
    
        [self addSubview:sendBtn];
        
        self.sentBtn = sendBtn;
        
    }
    
    return self;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews{
    
    [super layoutSubviews];

    CGFloat btnW = self.frame.size.width/5;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    
    self.sentBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    NSInteger index = 0;
    
    for (UIView *tabBarBtn in self.subviews) {
        // 把tabBarBtn的类名转化为字符串
        NSString *str = NSStringFromClass(tabBarBtn.class);
        
        // 判断字符串是否为"UITabBarButton"，不是就不取，以确保取出来的控件都是UITabBarButton
        if (![str isEqualToString:@"UITabBarButton"]) continue;
        
        //设置x值
        CGFloat btnX = index * btnW;
        
        //中间空一格出来
        if (index >= 2) {
            btnX += btnW;
        }
        
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        index++;
    }
    
    
    
}

@end
