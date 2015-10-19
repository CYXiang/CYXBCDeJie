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

/** 评论内容 */
@property (nonatomic,copy) NSString *content;

/** 发表这条评论的用户 */
@property (strong, nonatomic) CYXUser *user;

@end
