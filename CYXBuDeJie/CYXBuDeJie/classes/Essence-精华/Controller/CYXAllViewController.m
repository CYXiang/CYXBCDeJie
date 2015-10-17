//
//  CYXAllViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/15.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXAllViewController.h"
#import "CYXHTTPSessionManager.h"
#import "CYXTopic.h"
#import "CYXTopicCell.h"
#import <MJExtension.h>

@interface CYXAllViewController ()

/** 请求管理者 */
@property (nonatomic,weak) CYXHTTPSessionManager * manager;

/** 帖子模型数组 */
@property (strong, nonatomic) NSArray * topics;
@end

@implementation CYXAllViewController

static NSString *const CYXTopicCellID = @"topic";

/** manager 属性懒加载*/
- (CYXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [CYXHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(CYXNavBarBottom + CYXTitlesViewH, 0, CYXTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.rowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXTopicCell class]) bundle:nil] forCellReuseIdentifier:CYXTopicCellID];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"type"] = @"1",
    params[@"c"] = @"data";
    
    
    __weak typeof(self) weakSelf = self;
    // 发送请求
   [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       weakSelf.topics =  [CYXTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
       CYXLog(@"%@ ",responseObject);
       [weakSelf.tableView reloadData];
       
   } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
       
   }];
    
    CYXLogFuc;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXTopicCellID];

    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

@end
