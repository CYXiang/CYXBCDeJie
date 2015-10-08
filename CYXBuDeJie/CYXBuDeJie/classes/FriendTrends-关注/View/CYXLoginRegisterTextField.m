//
//  CYXLoginRegisterTextField.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/3.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXLoginRegisterTextField.h"

@implementation CYXLoginRegisterTextField

- (void)awakeFromNib{
    self.tintColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    
    // 修改占位文字颜色（KVC）
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
    
    // 当选中文本框的时候通过addTarget方法改变占位文字的颜色
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editingDitEnd) forControlEvents:UIControlEventEditingDidEnd];
    
}


- (void)editingDidBegin{
    // KVC
    [self setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
}

- (void)editingDitEnd{

    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
}



@end
