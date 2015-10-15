//
//  CYXClearCacheCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/13.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXClearCacheCell.h"

@implementation CYXClearCacheCell

#define CYXCacheFilePath [NSS]

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.text = @"清除缓存";
        
        // 右边显示一个圈圈
        UIActivityIndicatorView * loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        // 开始动画
        [loadingView startAnimating];
        // 赋值给右边的控件
        self.accessoryView = loadingView;
        // 开启异步线程计算数据
        [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
            // 计算缓存的大小
            // 单位
            double unit = 1000.0;
            unsigned long long fileSize = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"default"].fileSize;
//            unsigned long long fileSize = @"/Users/Macx/Desktop/本地课堂共享".fileSize;

            
            NSString *text = [NSString stringWithFormat:@"清除缓存(%zd)B",fileSize] ;
            
            // 回到主线程更新UI
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.textLabel.text = text;
                // 去掉菊花
                self.accessoryView = nil;
                
                self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            }];

        }];
        
        // 添加手势监听器
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];
    }
    
    return self;
    
}

- (void)clearCache{
    CYXLogFuc;
}

@end
