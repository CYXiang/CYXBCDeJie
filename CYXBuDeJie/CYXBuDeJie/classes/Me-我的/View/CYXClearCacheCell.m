//
//  CYXClearCacheCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/13.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXClearCacheCell.h"

@implementation CYXClearCacheCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.text = @"清除缓存";
        
        // 右边显示一个圈圈
        UIActivityIndicatorView * loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        // 开始动画
        [loadingView startAnimating];
        
        self.accessoryView = loadingView;
        
        
    }
    
    return self;
    
}

@end
