//
//  CYXCommentViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/26.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXCommentViewController.h"
#import "CYXCommentCell.h"
#import "CYXComment.h"
#import "CYXTopic.h"
#import "CYXHTTPSessionManager.h"
#import "CYXTopicCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface CYXCommentViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

/** 请求管理者 */
@property (nonatomic,weak) CYXHTTPSessionManager * manager;
/** 最热评论 */
@property (strong, nonatomic) NSArray<CYXComment *> * hotestComments;
/** 最新评论 */
@property (strong, nonatomic) NSMutableArray<CYXComment *> * latestComments;
/** 保存最热评论 */
//@property (strong, nonatomic) id top_cmt;

@end

@implementation CYXCommentViewController

static NSString *const CYXCommentCellID = @"comment";

/** manager属性懒加载*/
- (CYXHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [CYXHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBase];
    
    [self setupTable];
    
    [self setupTableHeader];

}

- (void)setupBase{
    
    self.navigationItem.title = @"评论";
    // 添加观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)setupTable{
    self.commentTable.backgroundColor = CYXCommonBgColor;
    self.commentTable.rowHeight = UITableViewAutomaticDimension;
    self.commentTable.estimatedRowHeight = 100;
    
    // 注册
    [self.commentTable registerNib:[UINib nibWithNibName:NSStringFromClass([CYXCommentCell class]) bundle:nil] forCellReuseIdentifier:CYXCommentCellID];
    
    // 头部控件
    UIView *header = [[UIView alloc]init];
//    header.backgroundColor = [UIColor redColor];
    header.heigth = 200;
    
    self.commentTable.tableHeaderView = header;
    
    self.commentTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.commentTable.header beginRefreshing];
    self.commentTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
}

- (void)setupTableHeader{
    // 处理模型数据
//    if (self.topic.top_cmt) { // 有最热评论
//        self.top_cmt = self.topic.top_cmt;
//        self.topic.top_cmt = nil;
//        self.topic.cellHeight = 0;// 重写计算高度
//    }
    
    UIView *headerView = [[UIView alloc]init];
    
    // 添加TopicCell到头部视图中
    CYXTopicCell *cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([CYXTopicCell class]) owner:nil options:nil].lastObject;
    // 设置模型数据
    cell.topic = self.topic;
    // 设置Cell的frame
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [headerView addSubview:cell];
    // 设置headerView的高度
    headerView.heigth = cell.heigth + 2 * CYXMargin;
    
    // 设置header
    self.commentTable.tableHeaderView = headerView;
    
}

- (void)dealloc{
    // 移除观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
//    if (self.top_cmt) {
//        self.topic.top_cmt = self.top_cmt;
//        self.topic.height = 0;
//    }
    
}

#pragma mark - 监听函数
- (void)keyboardWillChangeFrame:(NSNotification *)note{
    
    // 设置约束值
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = [UIScreen mainScreen].bounds.size.height - keyboardF.origin.y;
    
    // 动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
#pragma mark - 加载数据
- (void)loadNewComments{

    // 取消之前的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"hot"] = @"1";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.id;
    CYXLog(@"%@",self.topic.id);
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        weakSelf.hotestComments = [CYXComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        CYXLog(@"%@",responseObject[@"hot"]);
        weakSelf.latestComments = [CYXComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 刷新表格
        [weakSelf.commentTable reloadData];
        // 结束刷新
        [weakSelf.commentTable.header endRefreshing];
        
        NSInteger total = [responseObject[@"total"]integerValue];
        if (weakSelf.latestComments.count == total) {
            weakSelf.commentTable.footer.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        [weakSelf.commentTable.header endRefreshing];
    }];
}
/**
 *  加载更多数据
 */
- (void)loadMoreComments{
    
    // 取消之前的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.id;
    params[@"lastcid"] = self.latestComments.lastObject.id;

    __weak typeof(self) weakSelf = self;
    
    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 判断如果没有数据就结束刷新
        if ([responseObject isKindOfClass:[NSArray class]]) {
            weakSelf.commentTable.footer.hidden = YES;
            return ;
        }
        
       NSArray *moreComments = [CYXComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [weakSelf.latestComments addObjectsFromArray:moreComments];
        
        // 刷新表格
        [weakSelf.commentTable reloadData];
        // 结束刷新
        
        NSInteger total = [responseObject[@"total"]integerValue];
        if (weakSelf.latestComments.count == total) {
            weakSelf.commentTable.footer.hidden = YES;
        }else{
            [weakSelf.commentTable.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.commentTable.footer endRefreshing];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.hotestComments.count) {
        return 2;
    }else if (self.latestComments.count){
        return 1;
    }else{
        return 0;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.hotestComments.count && section == 0) {
        return self.hotestComments.count;
    }else{
        return self.latestComments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYXCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXCommentCellID];
    
    if (self.hotestComments.count && indexPath.section == 0) {
        cell.comment = self.hotestComments[indexPath.row];
    }else{
        cell.comment = self.latestComments[indexPath.row];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0 && self.hotestComments.count) {
        return @"最热评论";
    }
    return @"最新评论";
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
