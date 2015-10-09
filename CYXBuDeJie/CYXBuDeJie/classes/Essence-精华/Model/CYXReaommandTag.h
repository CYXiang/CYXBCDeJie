//
//  CYXReaommandTag.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/9.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYXReaommandTag : NSObject

/** 名字 */
@property (nonatomic,copy) NSString *theme_name;
/** 图片 */
@property (nonatomic,copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic,assign) NSInteger  sub_number;

@end
