//
//  CYXSettingViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/30.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXSettingViewController.h"
#import "CYXClearCacheCell.h"

@interface CYXSettingViewController ()

@end

@implementation CYXSettingViewController

static NSString *const CYXClearCellID = @"clear_cell";
static NSString *const CYXOtherCellID = @"other_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CYXCommonBgColor;
    
    [self.tableView registerClass:[CYXClearCacheCell class] forCellReuseIdentifier:CYXClearCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CYXOtherCellID];
    
    self.navigationItem.title = @"设置";
}

- (void)getCatchSize{

    
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
    
    if (indexPath.section == 0) {
        CYXClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:CYXClearCellID];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:CYXOtherCellID];
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIViewController *testVC = [UIStoryboard storyboardWithName:@"Test" bundle:nil].instantiateInitialViewController;
    
//    [self.navigationController pushViewController:testVC animated:YES];
    
    
}


@end
