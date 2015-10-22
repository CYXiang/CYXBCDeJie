//
//  CYXSeeBigViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/22.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXSeeBigViewController.h"
#import "CYXTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface CYXSeeBigViewController () <UIScrollViewDelegate>

/** <#注释#> */
@property (nonatomic,weak) UIImageView * imageView;

@end

@implementation CYXSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    // 插入到最底层，避免遮住按钮
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.width = scrollView.width;
    imageView.heigth = self.topic.height * imageView.width / self.topic.width;
    imageView.x = 0;
    if (imageView.heigth >= scrollView.heigth) { // 图片高度超过整个屏幕
        imageView.y = 0;
    } else { // 居中显示
        imageView.centerY = scrollView.heigth * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 滚动范围
    scrollView.contentSize = CGSizeMake(0, imageView.heigth);
    
    // 缩放比例
    CGFloat maxScale = self.topic.height / imageView.heigth;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick)]];
    
    // imageView 370 x 400
    // 真实图片 300 x 340
}

- (IBAction)backBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClick{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView内部的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
