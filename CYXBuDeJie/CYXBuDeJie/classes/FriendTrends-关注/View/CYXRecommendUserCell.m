//
//  CYXRecommendUserCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/25.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommendUserCell.h"
#import "CYXRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface CYXRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;



@end

@implementation CYXRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(CYXRecommendUser *)user{
    
    _user = user;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header]];
    
    self.screenNameLabel.text = user.screen_name;
    
    if (user.fans_count >= 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }else{
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }
    
    
}

@end
