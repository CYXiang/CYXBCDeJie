//
//  CYXRecommandTagViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/8.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommandTagViewController.h"
#import "CYXRecommandTagCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@interface CYXRecommandTagViewController ()

@end

@implementation CYXRecommandTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.tableView.rowHeight = 70;
    
    [self loadNewRecommandTags];
    
    // 注册可重用TableViewCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:@"recommandTag"];
}

/**
 *  发送请求的方法
 */
- (void)loadNewRecommandTags{

    NSString *url = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        CYXLog(@"成功");
        CYXLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        CYXLog(@"失败");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommandTag"];
    
    // Configure the cell...
    
    return cell;
}



@end
