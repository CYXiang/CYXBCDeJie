//
//  CYXExtensionConfig.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/19.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXExtensionConfig.h"
#import "CYXTopic.h"
#import "CYXComment.h"
#import <MJExtension.h>

@implementation CYXExtensionConfig


+ (void)load{
    [CYXTopic setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 };
    }];
}

@end
