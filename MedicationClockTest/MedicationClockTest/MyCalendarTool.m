//
//  MyCalendarTool.m
//  MedicationClockTest
//
//  Created by 歐陽 on 16/3/23.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "MyCalendarTool.h"

@implementation MyCalendarTool

+ (NSString*)getStrFromDate:(NSDate*)date{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    //设置自定义的格式
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr=[format stringFromDate:date];
    return dateStr;
}
+ (NSString*)getStrFromDate:(NSDate*)date formatStr:(NSString*)formatStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    //设置自定义的格式
    [format setDateFormat:formatStr];
    NSString *dateStr=[format stringFromDate:date];
    return dateStr;
}

+ (NSDate*)getDateFromStr:(NSString*)dateStr{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:dateStr];
    return date;
}
+ (NSDate*)getDateFromStr:(NSString*)dateStr formatStr:(NSString*)formatStr{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:formatStr];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:dateStr];
    return date;
}

//获取某月的1号是星期几
+ (long)getFirstWeekDayInMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

//获取某一月的天数
+ (long)getNumDaysInMonth:(NSDate *)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}

@end
