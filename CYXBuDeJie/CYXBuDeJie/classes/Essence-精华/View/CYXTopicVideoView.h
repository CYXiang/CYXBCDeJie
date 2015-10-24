//
//  CYXTopicVideoView.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYXTopic;
@interface CYXTopicVideoView : UIView

+ (instancetype)videoView;

/** 模型 */
@property (strong, nonatomic) CYXTopic * topic;
@end
