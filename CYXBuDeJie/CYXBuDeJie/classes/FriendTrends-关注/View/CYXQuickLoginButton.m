//
//  CYXQuickLoginButton.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/3.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "CYXQuickLoginButton.h"
#import "UIView+CYXFrame.h"


@implementation CYXQuickLoginButton

- (void)awakeFromNib{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 设置图片
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    // 设置文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.heigth;
    self.titleLabel.width = self.width;
    self.titleLabel.heigth = self.heigth - self.titleLabel.y;
    
}


@end
