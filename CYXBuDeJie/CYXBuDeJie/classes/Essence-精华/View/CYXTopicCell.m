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


@end

@implementation CYXTopicCell

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
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        
        NSString *content = topic.top_cmt.content;
        NSString *userName = topic.top_cmt.user.username;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",userName,content];
        
        
    }else{
        self.topCmtView.hidden = YES;
    }
    
}

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
