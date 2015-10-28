//
//  CYXComment.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/19.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYXUser;

@interface CYXComment : NSObject
/** id */
@property (nonatomic, copy) NSString *id;

/** 评论内容 */
@property (nonatomic, copy) NSString *content;

/** 发表这条评论的用户 */
@property (nonatomic, strong) CYXUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

@end
