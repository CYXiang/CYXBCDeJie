//
//  CYXRecommandTagViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/8.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommandTagViewController.h"
#import "CYXRecommandTagCell.h"
#import "CYXReaommandTag.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface CYXRecommandTagViewController ()

/** 所有的标签数据 */
@property (strong, nonatomic) NSArray * recommandTags;

/** 请求管理者 */
@property (strong, nonatomic) AFHTTPSessionManager * manager;

@end

/*
 1.定义一个[只能在当前文件访问]的[全局常量]
 1> static 类型 const 常量名 = 初始化值;
 
 2.定义一个[整个项目都能访问]的[全局常量]
 1> 新建2个文件
 a) 1个.h\1个.m
 b) 比如XMGConst.h和XMGConst.m
 2> 在XMGConst.h和XMGConst.m中包含UIKit
 a) #import <UIKit/UIKit.h>
 3> 在XMGConst.m定义常量值
 a) 类型 const 常量名 = 初始化值;
 4> 在XMGConst.h引用常量
 a) UIKIT_EXTERN 类型 const 常量名;
 5) 在pch文件中包含XMGConst.h
 a) #import "XMGConst.h"
 */

// cell的重用标识
static NSString * const CYXRecommandCellID = @"recommandTag";

@implementation CYXRecommandTagViewController

/** mamager 属性懒加载*/
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.tableView.rowHeight = 70;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = CYXCommonBgColor;
    
    // 到服务器加载标签数据
    [self loadNewRecommandTags];
    
    // 注册可重用TableViewCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:CYXRecommandCellID];
}

/**
 *  发送请求的方法
 */
- (void)loadNewRecommandTags{

    [SVProgressHUD show];
    
    NSString *url = CYXRequestURL;
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [self.manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        CYXLog(@"成功");

        weakSelf.recommandTags = [CYXReaommandTag objectArrayWithKeyValuesArray:responseObject];
//        CYXLog(@"%@",self.recommandTags);
        
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CYXLog(@"失败");
        [SVProgressHUD dismiss];
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    // 取消当前所有请求
    [self.manager invalidateSessionCancelingTasks:YES];
    [SVProgressHUD dismiss];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommandTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CYXRecommandTagCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXRecommandCellID];
    
    cell.reaommandTag = self.recommandTags[indexPath.row];
    
    return cell;
}



@end
