//
//  CYXCommentViewController.h
//  CYXBuDeJie
//
//  Created by Macx on 15/10/26.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYXTopic;
@interface CYXCommentViewController : UIViewController

/** 帖子模型数据 */
@property (strong, nonatomic) CYXTopic * topic;

@end
