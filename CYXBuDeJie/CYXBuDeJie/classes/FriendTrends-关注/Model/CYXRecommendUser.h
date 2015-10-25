//
//  CYXRecommendUser.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/25.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYXRecommendUser : NSObject

/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;

@end
