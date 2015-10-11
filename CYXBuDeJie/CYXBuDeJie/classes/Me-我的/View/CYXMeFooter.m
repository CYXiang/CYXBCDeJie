//
//  CYXMeFooter.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/11.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXMeFooter.h"
#import "CYXMeSquare.h"
#import "CYXSquareButton.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>

@implementation CYXMeFooter

/**
 *  添加子控件
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"a"] = @"square";
        param[@"c"] = @"topic";
        
        __weak typeof(self) weakSelf = self;
        
        // 发送请求
        [[AFHTTPSessionManager manager]GET:CYXRequestURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            CYXLog(@"%@",responseObject);
            [responseObject writeToFile:@"/Users/Macx/Desktop/杂/me.plist" atomically:YES];
            NSArray *squares = [CYXMeSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            CYXLog(@"%@",squares);
            
            [weakSelf createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            CYXLog(@"请求失败----%@",error);
        }];
        
    }
    return self;

}

/**
 *  根据模型数据创建方块
 *
 *  @param squares 模型数据
 */
- (void)createSquares:(NSArray *)squares{
    
    // 一行有几列
    int col = 4;
    NSUInteger count = squares.count;
    
    CGFloat buttonW = self.width / col;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < count; i++) {
        // 添加子控件
        CYXSquareButton *button = [CYXSquareButton buttonWithType:UIButtonTypeCustom];
        
        button.backgroundColor = CYXRandomColor;
        
        [self addSubview:button];
        
        // 设置frame
        button.width = buttonW;
        button.heigth = buttonH;
        button.x = (i % col) * buttonW;
        button.y = (i / col) * buttonH;
        
        // 设置数据
        
        CYXMeSquare *square = squares[i];
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        
    }
    
}


@end
