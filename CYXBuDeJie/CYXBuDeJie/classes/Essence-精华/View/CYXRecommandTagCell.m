//
//  CYXRecommandTagCell.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/8.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXRecommandTagCell.h"
#import "CYXReaommandTag.h"
#import <UIImageView+WebCache.h>


@interface CYXRecommandTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLable;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLable;

@end

@implementation CYXRecommandTagCell


- (void)setReaommandTag:(CYXReaommandTag *)reaommandTag{

    _reaommandTag = reaommandTag;
    
    // 通过SDWebImage加载图片
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString: reaommandTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLable.text = reaommandTag.theme_name;
    
    // 订阅数
    if (reaommandTag.sub_number >= 10000) {
        self.subNumberLable.text = [NSString stringWithFormat:@"%.1f万人订阅",reaommandTag.sub_number / 10000.0];
    }else{
        self.subNumberLable.text = [NSString stringWithFormat:@"%zd人订阅",reaommandTag.sub_number];
    }
    

}

/**
 *  重写setFrame的作用：监听设置Cell的frame设置过程
 */
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
