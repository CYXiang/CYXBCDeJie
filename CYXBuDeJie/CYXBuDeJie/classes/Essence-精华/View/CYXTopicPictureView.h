//
//  CYXTopicPictureView.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/19.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYXTopic;

@interface CYXTopicPictureView : UIView

+ (instancetype)pictureView;
/** 帖子模型数据 */
@property (strong, nonatomic) CYXTopic * topic;

@end
