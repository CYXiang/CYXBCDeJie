//
//  CYXTopicCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/17.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopicCell.h"
#import "CYXTopic.h"
#import "CYXComment.h"
#import "CYXUser.h"
#import "CYXTopicPictureView.h"
#import "CYXTopicVideoView.h"
#import "CYXTopicVoiceView.h"

@interface CYXTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;


/** 图片控件 */
@property (nonatomic,weak) CYXTopicPictureView * pictureView;
/** 声音控件 */
@property (nonatomic,weak) CYXTopicVoiceView * voiceView;
/** 视频控件 */
@property (nonatomic,weak) CYXTopicVideoView * videoView;
@end

@implementation CYXTopicCell

/** pictureView 属性懒加载*/
- (CYXTopicPictureView *)pictureView
{
    if (!_pictureView) {
        CYXTopicPictureView *pictureView = [CYXTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

/** voiceView 数据懒加载*/
- (CYXTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        CYXTopicVoiceView *voiceView = [CYXTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

/** videoView 数据懒加载*/
- (CYXTopicVideoView *)videoView
{
    if (!_videoView) {
        CYXTopicVideoView *videoView = [CYXTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}



- (void)awakeFromNib{
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"mainCellBackground"]];
}

/**
 *  这个方法调用非常频繁
 */
- (void)setTopic:(CYXTopic *)topic{
    _topic = topic;
    
    [self.profileImageView setHeaderWithURL:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.text_label.text = topic.text;
    self.createdAtLabel.text = topic.created_at;
    
    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",topic.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",topic.cai] forState:UIControlStateNormal];
    [self.repostButton setTitle:[NSString stringWithFormat:@"%zd",topic.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",topic.comment] forState:UIControlStateNormal];
    
    // 是否显示最热评论
    CYXLog(@"%@",topic.top_cmt);

    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        
        NSString *content = topic.top_cmt.content;
        NSString *userName = topic.top_cmt.user.username;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
    // 中间的具体内容
    if (topic.type == CYXTopicTypePicture) {// 显示图片
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.centerViewFrame; // 尺寸
        self.pictureView.topic = topic; // 数据
        
    }else if (topic.type == CYXTopicTypeVoice){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.voiceView.hidden  =NO;
        self.voiceView.frame = topic.centerViewFrame;
        self.voiceView.topic = topic;
        
    }else if (topic.type == CYXTopicTypeVideo){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
        self.videoView.hidden = NO;
        self.videoView.frame = topic.centerViewFrame;
        self.videoView.topic = topic;
        
    }else{// 文字
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
}
/**
 *  重写setFrame方法，增加间距
 */
- (void)setFrame:(CGRect)frame{

    frame.origin.y += CYXMargin;
    frame.size.height -= CYXMargin;
    [super setFrame:frame];
}
/**
 *  点击右上角的按钮
 */
- (IBAction)moveBtnClick:(UIButton *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CYXLog(@"点击了【收藏】");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CYXLog(@"点击了【举报】");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CYXLog(@"点击了【取消】");
    }]];
    
    // 通过Modal出来
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


@end
