//
//  CYXTopic.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/17.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXTopic.h"
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

@end
