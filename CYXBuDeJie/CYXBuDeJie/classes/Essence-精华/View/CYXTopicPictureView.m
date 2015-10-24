//
//  CYXTopicPictureView.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/19.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopicPictureView.h"
#import "CYXTopic.h"
#import "CYXSeeBigViewController.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

@interface CYXTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gitView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@property (nonatomic, weak) IBOutlet DALabeledCircularProgressView * progressView;

@end

@implementation CYXTopicPictureView

+ (instancetype)pictureView{
    // 返回从Xib加载的View
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    // 去除默认的autoresizingMask属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 初始化 设置progressView属性
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    
    self.imageView.userInteractionEnabled = YES;
    // 监听图片点击，添加Tap手势
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
    
}

- (void)imageClick{
    if (self.imageView.image == nil) {
        return;
    }
    
    CYXSeeBigViewController *seeBVc = [[CYXSeeBigViewController alloc]init];
    
    seeBVc.topic = self.topic;
    
    [self.window.rootViewController presentViewController:seeBVc animated:YES completion:nil];
    
}


- (void)setTopic:(CYXTopic *)topic{

    _topic = topic;
    //
    /**
     *  显示带进度条的图片
     *
     *  @param receivedSize <#receivedSize description#>
     *  @param expectedSize <#expectedSize description#>
     *
     *  @return <#return value description#>
     */
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {// 这个block可能被调用多次
        // 显示正在下载的提醒
        self.progressView.hidden = NO;
        self.placeholderView.hidden = NO;
        
        // 显示进度值
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        
        // 显示进度值label
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        self.placeholderView.hidden = YES;
    }];
    
    
    // 判断是否隐藏显示大图的按钮
    self.seeBigButton.hidden = !topic.isBigPicture;
    // 判断是否隐藏gif图片的标识
    self.gitView.hidden = !topic.is_gif;
    
    if (topic.isBigPicture) {
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        // 因为cell的循环利用，上面设了YES，下面设回NO
        self.imageView.clipsToBounds = NO;
    }
    
    
}

@end
