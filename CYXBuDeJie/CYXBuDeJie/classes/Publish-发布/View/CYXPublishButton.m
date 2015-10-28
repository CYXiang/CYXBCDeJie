//
//  CYXPublishButton.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXPublishButton.h"

@implementation CYXPublishButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.heigth = self.heigth - self.titleLabel.y;
    
}

@end
