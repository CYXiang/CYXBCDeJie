//
//  CYXEssenceController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/9/28.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXEssenceController.h"
#import "CYXRecommandTagViewController.h"
#import "CYXTitleButton.h"
#import "CYXAllViewController.h"
#import "CYXPictureViewController.h"
#import "CYXVideoViewController.h"
#import "CYXVoiceViewController.h"
#import "CYXWordViewController.h"


@interface CYXEssenceController ()<UIScrollViewDelegate>

/** 被选中的按钮 */
@property (nonatomic,weak) CYXTitleButton * selectedTitleButton;

/** 标题指示器 */
@property (nonatomic,weak) UIView * titleIndicatorView;

/** 存放所有子控制器的scrollView */
@property (nonatomic,weak) UIScrollView * scrollView;

/** 存放所有的标题按钮 */
@property (strong, nonatomic) NSMutableArray * titleButtons;
@end

@implementation CYXEssenceController

/** titleButton 数据懒加载*/
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self setupChildViewControllers];
    
    // 设置顶部导航条
    [self setupNav];
    
    // 添加scrollView
    [self setupScollView];

    // 添加标题栏
    [self setupTitlesView];
    
    // 初始化第一个控制器的View
    [self addChildContentView];
}

- (void)setupChildViewControllers{
    
    CYXAllViewController *all = [[CYXAllViewController alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    CYXVideoViewController *video = [[CYXVideoViewController alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    CYXVoiceViewController *voice = [[CYXVoiceViewController alloc]init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    CYXPictureViewController *picture = [[CYXPictureViewController alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    CYXWordViewController *word = [[CYXWordViewController alloc]init];
    word.title = @"段子";
    [self addChildViewController:word];
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
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    // 禁止【自动设置ScrollView内边距】
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置滚动内容的大小
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
    
    
}

/**
 *  设置标题栏
 */
- (void)setupTitlesView{
    
    UIView *titlesView = [[UIView alloc]initWithFrame: CGRectMake(0, 64, self.view.width, 40)];
    NSArray *title = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    //添加标题栏
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titlesView];
    
    CGFloat titleButtonW = titlesView.width / title.count;
    CGFloat titleButtonH = titlesView.heigth;
    
    // 添加五个标题按钮
    for (int i = 0; i < 5; i++) {
        CYXTitleButton *titleButton = [[CYXTitleButton alloc]init];
        
        [titleButton setTitle:title[i] forState:UIControlStateNormal];
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.tag = i;
        [self.titleButtons addObject:titleButton];
        
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [titlesView addSubview:titleButton];
    }
    
    // 添加底部指示器
    UIView *titleIndicatorView = [[UIView alloc]init];
    [titlesView addSubview: titleIndicatorView];
    
    // 设置指示器背景色为按钮的选中文字颜色
    CYXTitleButton *selectButton = titlesView.subviews.firstObject;
    titleIndicatorView.backgroundColor = [selectButton titleColorForState:UIControlStateSelected];
    titleIndicatorView.heigth = 1;
    titleIndicatorView.bottom = titlesView.heigth;
    self.titleIndicatorView = titleIndicatorView;
    
    selectButton.selected = YES;
    self.selectedTitleButton = selectButton;
    
    [selectButton.titleLabel sizeToFit];
    
    titleIndicatorView.width = selectButton.titleLabel.width;
    titleIndicatorView.centerX = selectButton.centerX;

}
/**
 *  点击标题事件监听
 */
- (void)titleButtonClick:(CYXTitleButton *)button{
    // 恢复旧的选中状态
    self.selectedTitleButton.selected = NO;
    // 设置新的选中状态
    button.selected = YES;
    // 赋值
    self.selectedTitleButton = button;
    // 滚动指示器
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleIndicatorView.width = button.titleLabel.width;
        self.titleIndicatorView.centerX = button.centerX;
    }];
    
    // 滚动scrollView
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

/**
 *  通过setContentOffset:animated方法滚动ScrollView,动画停止的时候调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 根据scrollView的偏移量的添加子控制器的view
    [self addChildContentView];
}

/**
 *  scrollView停止滚动的时候会调一次这个方法（人为拖动才会调）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    int index = scrollView.contentOffset.x / scrollView.width;
    CYXTitleButton *titleButton = self.titleButtons[index];
    
    [self titleButtonClick:titleButton];
    
    [self addChildContentView];
}



- (void)addChildContentView{
    
    UIScrollView *scrollView = self.scrollView;
    
    // 取出子控制器
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 避免重复加载
    if (willShowVc.isViewLoaded) {
        return;
    }
    
    // 把子控制器的View加到scrollView中
    [scrollView addSubview:willShowVc.view];
    
    // 设置子控制器View的尺寸
    willShowVc.view.frame = scrollView.bounds;
    
    
}
@end
