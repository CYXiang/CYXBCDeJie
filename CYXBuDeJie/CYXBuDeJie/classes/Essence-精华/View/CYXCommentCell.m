//
//  CYXCommentCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/26.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXCommentCell.h"
#import "CYXComment.h"
#import "CYXUser.h"

@interface CYXCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation CYXCommentCell

- (void)awakeFromNib {

    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];

}

- (void)setComment:(CYXComment *)comment{
    _comment = comment;
    
    [self.profileImageView setHeaderWithURL:comment.user.profile_image];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    NSString *sexImage = [comment.user.sex isEqualToString:@"m"] ?  @"Profile_manIcon" :@"Profile_womanIcon";
    [self.sexView setImage:[UIImage imageNamed:sexImage]];

    
}

@end
