//
//  CYXEssenceController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXEssenceController.h"
#import "CYXRecommandTagViewController.h"


@interface CYXEssenceController ()

/** 被选中的按钮 */
@property (nonatomic,weak) UIButton * selectedTitleButton;

@end

@implementation CYXEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置顶部导航条
    [self setupNav];
    
    // 添加scrollView
    [self setupScollView];

    // 添加标题栏
    [self setupTitlesView];
}

/**
 *  顶部导航条的设置
 */
- (void)setupNav{
    
    self.view.backgroundColor = CYXCommonBgColor;
    
    // 设置标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置左上角按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimageName:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(mainBtnClick) ];
}

/**
 *  顶部导航条的左边按钮点击事件
 */
- (void)mainBtnClick{
    
    CYXRecommandTagViewController *tag = [[CYXRecommandTagViewController alloc]init];

    [self.navigationController pushViewController:tag animated:YES];
}

/**
 *  添加ScrollView
 */
- (void)setupScollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = CYXRandomColor;
    [self.view addSubview:scrollView];
    
}

/**
 *  设置标题栏
 */
- (void)setupTitlesView{
    
    UIView *titlesView = [[UIView alloc]initWithFrame: CGRectMake(0, 64, self.view.width, 40)];
    // 添加五个标题按钮
    NSArray *title = @[@"全部",@"视频",@"图片",@"音乐",@"段子"];
    
    CGFloat titleButtonW = titlesView.width / title.count;
    CGFloat titleButtonH = titlesView.heigth;
    
    for (int i = 0; i < 5; i++) {
        UIButton *titleButton = [[UIButton alloc]init];
        
        [titleButton setTitle:title[i] forState:UIControlStateNormal];
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [titlesView addSubview:titleButton];
    }
    
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titlesView];
}

- (void)titleButtonClick:(UIButton *)button{
    
    self.selectedTitleButton.selected = NO;
    
    button.selected = YES;
    
    self.selectedTitleButton = button;
    
    CYXLog(@"%@",button.titleLabel.text);
}

@end
