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

- (void)setTopic:(CYXTopic *)topic{

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.seeBigButton.hidden = !topic.isBigPicture;
    
    self.gitView.hidden = !topic.is_gif;
    
    
}

@end
