//
//  CYXMeController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXMeController.h"
#import "CYXSettingViewController.h"
#import "CYXMeCell.h"
#import "CYXMeFooter.h"
#import "CYXLoginViewController.h"

@interface CYXMeController ()

@end

@implementation CYXMeController

static NSString * const CYXMeCellID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置表格
    [self setupTable];
    
    // 设置导航栏
    [self setupNav];
    
    

}

/**
 *  设置表格
 */
- (void)setupTable{
    self.tableView.backgroundColor = CYXCommonBgColor;
    
    [self.tableView registerClass:[CYXMeCell class] forCellReuseIdentifier:CYXMeCellID];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = CYXMargin;
    // 代码应该写到上面
    self.tableView.contentInset = UIEdgeInsetsMake(CYXMargin - CYXGroupFirstCellY, 0, 0, 0);
    
    // 九宫格使用footerView
    self.tableView.tableFooterView = [[CYXMeFooter alloc]init];
    

    
}


/**
 *  设置导航栏
 */
- (void)setupNav{
    // 设置标题
    self.navigationItem.title = @"我的";
    
    // 设置右上角的按钮
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithimageName:@"mine-moon-icon" highlightImage:@"mine-sun-icon-click" target:self action:@selector(moonBtnClick)];
    
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithimageName:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(setBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[item2,item1];
}



- (void)moonBtnClick{
    CYXLogFuc;
}

/**
 *  设置按钮的点击事件
 */
- (void)setBtnClick{
    
    CYXSettingViewController *setVC = [[CYXSettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:setVC animated:YES];
    

}

#pragma mark - TableView DataSoures

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CYXMeCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXMeCellID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登陆/注册";
    }else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"CYXTestViewController" bundle:nil];
        // 根据storyboard ID取到所需的
        CYXLoginViewController *vc = [st instantiateViewControllerWithIdentifier:@"CYXLoginViewController"];

        [self presentViewController:vc animated:YES completion:nil];
    
    
}

@end
