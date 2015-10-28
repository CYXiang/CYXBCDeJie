//
//  CYXRecommendCategory.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYXRecommendCategory : NSObject

/** 名字 */
@property (nonatomic,copy) NSString *name;
/** id */
@property (nonatomic,copy) NSString *id;


/** 用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 页码 */
@property (nonatomic, assign) NSInteger page;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
@end
