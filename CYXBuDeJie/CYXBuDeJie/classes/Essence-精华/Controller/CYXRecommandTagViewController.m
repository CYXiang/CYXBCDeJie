//
//  CYXRecommandTagViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/8.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommandTagViewController.h"
#import "CYXRecommandTagCell.h"

@interface CYXRecommandTagViewController ()

@end

@implementation CYXRecommandTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.tableView.rowHeight = 70;
    
[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:@"recommandTag"];
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
