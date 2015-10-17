//
//  CYXTopicCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/17.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopicCell.h"
#import "CYXTopic.h"

@interface CYXTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
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
    
}

- (void)setFrame:(CGRect)frame{

    frame.origin.y += CYXMargin;
    frame.size.height -= CYXMargin;
    [super setFrame:frame];
}


@end
