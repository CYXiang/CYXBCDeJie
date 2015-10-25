//
//  CYXRecommendCategoryCell.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYXRecommendCategory;
@interface CYXRecommendCategoryCell : UITableViewCell

/** 分类的模型数据 */
@property (strong, nonatomic) CYXRecommendCategory * category;

@end
