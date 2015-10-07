//
//  UIView+CYXFrame.h
//
//  Created by Macx on 14/8/27.
//  Copyright (c) 2014年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  简化结构体的赋值，你可以直接使用
 *
 *  UIView.centerX = self.view.centerX;等方式直接取值与赋值
 */
@interface UIView (CYXFrame)

//只会生成get、set方法
/** centerX */
@property (nonatomic,assign) CGFloat  centerX;
/** centerY */
@property (nonatomic,assign) CGFloat  centerY;
/** width */
@property (nonatomic,assign) CGFloat  width;
/** heigth */
@property (nonatomic,assign) CGFloat  heigth;
/** x */
@property (nonatomic,assign) CGFloat  x;
/** y */
@property (nonatomic,assign) CGFloat  y;

@end
