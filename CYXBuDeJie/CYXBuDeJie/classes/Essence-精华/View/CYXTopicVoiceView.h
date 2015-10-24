//
//  CYXTopicVoiceView.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/24.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYXTopic;
@interface CYXTopicVoiceView : UIView

+ (instancetype)voiceView;

/** 帖子模型数据 */
@property (strong, nonatomic) CYXTopic * topic;

@end
