//
//  CYXCommentCell.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/26.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYXComment;
@interface CYXCommentCell : UITableViewCell

/** 模型数据 */
@property (strong, nonatomic) CYXComment * comment;

@end
