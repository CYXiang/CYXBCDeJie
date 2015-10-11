//
//  CYXSquareButton.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/11.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXSquareButton.h"

@implementation CYXSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    // 设置图片位置
    self.imageView.width = self.width * 0.5;
    self.imageView.heigth = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.heigth * 0.1;
    
    // 设置文字位置
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.heigth;
    self.titleLabel.width = self.width;
    self.titleLabel.heigth = self.heigth - self.titleLabel.y;
    
}

@end
