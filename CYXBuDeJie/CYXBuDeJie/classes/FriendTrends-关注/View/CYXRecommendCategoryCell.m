//
//  CYXRecommendCategoryCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommendCategoryCell.h"
#import "CYXRecommendCategory.h"

@interface CYXRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *selectHUD;


@end
@implementation CYXRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {// 选中
        self.nameLabel.textColor = [UIColor redColor];
        self.selectHUD.hidden = NO;
    }else{// 取消选中
        self.nameLabel.textColor = [UIColor darkGrayColor];
        self.selectHUD.hidden = YES;
    }
}

- (void)setCategory:(CYXRecommendCategory *)category{
    _category = category;
    
    self.nameLabel.text = category.name;
}

@end
