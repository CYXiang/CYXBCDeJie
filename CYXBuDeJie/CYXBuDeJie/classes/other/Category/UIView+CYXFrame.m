//
//  UIView+CYXFrame.m
//
//  Created by Macx on 14/8/27.
//  Copyright (c) 2014年 CYX. All rights reserved.
//

#import "UIView+CYXFrame.h"



@implementation UIView (CYXFrame)

- (CGFloat)centerX{
    
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerY{
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}

- (CGFloat)heigth{
    
    return self.frame.size.height;
}

- (void)setHeigth:(CGFloat)heigth{
    
    CGRect frame = self.frame;
    
    frame.size.height = heigth;
    
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
}

- (CGFloat)x{
    return  self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
    
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
    
}

@end