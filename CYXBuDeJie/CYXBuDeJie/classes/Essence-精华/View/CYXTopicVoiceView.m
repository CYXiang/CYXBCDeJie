//
//  CYXTopicVoiceView.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopicVoiceView.h"
#import "CYXTopic.h"
#import "CYXSeeBigViewController.h"
#import <UIImageView+WebCache.h>

@interface CYXTopicVoiceView ()

/** 图片 */
@property (nonatomic,weak) IBOutlet UIImageView *imageView ;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end

@implementation CYXTopicVoiceView

+ (instancetype)voiceView{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    // 监听图片点击
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

- (void)imageClick{
    if (self.imageView.image == nil) return;
    
    CYXSeeBigViewController *seeBig = [[CYXSeeBigViewController alloc]init];
    
    seeBig.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

- (void)setTopic:(CYXTopic *)topic{

    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text =[NSString stringWithFormat:@"%zd次播放", topic.playcount];

    NSInteger min = topic.voicetime / 60;
    NSInteger sec = topic.voicetime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
}

@end
