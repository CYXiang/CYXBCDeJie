//
//  CYXTopicPictureView.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/19.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopicPictureView.h"
#import "CYXTopic.h"
#import <UIImageView+WebCache.h>

@interface CYXTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gitView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CYXTopicPictureView

+ (instancetype)pictureView{
    // 返回从Xib加载的View
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    // 去除默认的autoresizingMask属性
    self.autoresizingMask = UIViewAutoresizingNone;
}


- (void)setTopic:(CYXTopic *)topic{

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
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
