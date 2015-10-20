//
//  CYXTopic.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/17.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopic.h"
#import "CYXComment.h"
#import "CYXUser.h"
#import <MJExtension.h>

@implementation CYXTopic

/**
 *  声明：数组属性中存放什么模型
 */
//+ (NSDictionary *)objectClassInArray{
//
//    return @{
//             @"top_cmt":@"CYXComment"
//             };
//}

/**
 *  声明：【模型属性名】对应的【字典的key】 key-mapping
 */
//+ (NSDictionary *)replacedKeyFromPropertyName{
//    return @{
//             @"top_cmt" : @"top_cmt[0]"
//             };
//}


/**
 *  重写get方法,日期处理的两种方法：方法一：自己实现NSDate判断是否为今天昨天的分类。适配iOS8以下版本
 */
- (NSString *)created_at{

    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    // 日期的格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 把返回的字符串转化为NSDate格式
    NSDate *createdAtDate = [fmt dateFromString:_created_at];
    
    if (createdAtDate.isThisYear) {// 今年
        if (createdAtDate.isToday) {// 今天
            // 获得当前时间
            NSDate *nowDate = [NSDate date];
            // 日历对象
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmp = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
            if (cmp.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前",cmp.hour];
            }else if(cmp.minute >= 1){ // 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if (createdAtDate.isYesterday){// 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    }else{  // 非今年
        return _created_at;
    }
}
/**
 *  中间控件的frame
 */
- (CGRect)centerViewFrame{
    
    // 【中间控件】的X值
    CGFloat centerViewX = CYXMargin;
    
    // 文字的Y值
    CGFloat textY = 55;
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * CYXMargin;
    // 文字的高度（通过Text文字计算）
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    // 【中间控件】的Y值
    CGFloat centerViewY = textY + textH + CYXMargin;
    
    // 【中间控件】的W值
    CGFloat centerViewW = textMaxW;

    
    // 【中间控件】的H值
    CGFloat centerViewH = self.height *centerViewW / self.width;
    
    if (centerViewH >= [UIScreen mainScreen].bounds.size.height) {
        centerViewH = 200;
        self.bigPicture = YES;
    }

    
    return CGRectMake(centerViewX, centerViewY, centerViewW, centerViewH);
}

- (CGFloat)cellHeight{

    // 文字的Y值
    CGFloat textY = 55;
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * CYXMargin;
    // 文字的高度
    CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight = textY + textH + CYXMargin;
    
    if (self.type != CYXTopicTypeWord) { // 有中间内容
        _cellHeight += self.centerViewFrame.size.height + CYXMargin;
    }
    
    if (self.top_cmt) { // 有最热评论
        CGFloat topCmtTitleH = 20;
        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@", self. top_cmt.user.username, self.top_cmt.content];
        CGFloat topCmtTextH = [topCmtText boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight += topCmtTitleH + topCmtTextH + CYXMargin;
    }
    
    // 底部工具条
    CGFloat toolbarH = 35;
    _cellHeight += toolbarH + CYXMargin;
    
    return _cellHeight;
}

@end
