//
//  MyCalendarView.m
//  MedicationClockTest
//
//  Created by 歐陽 on 16/3/23.
//  Copyright © 2016年 歐陽. All rights reserved.
//

#import "MyCalendarView.h"
#import "MyCalendarTool.h"
#import "ColorUtil.h"

//定义宏
#define Calendar_TopBarHeight 60
#define Calendar_DayHeight 35
#define PI 3.1415926535897932326433832795
#define NumRows 6
#define NumBlocks 42

@implementation MyCalendarView{
    //日历视图的宽
    int Calendar_Width;
    //日期格子的宽
    int Calendar_DayWidth;
    //顶部显示年月的文本框
    UILabel *_secMonthLable;
}

//设置标记日期列表的函数，供外部调用
-(void)setMarkDay:(NSArray *)markDay{
    _markDay = markDay;     //传入任务日期的数组
    [self setNeedsDisplay]; //刷新控件界面
}

/** 重写父类初始化函数 **/
- (id)init{
    self = [super init];
    if (self) {
        [self initDefault];
    }
    return self;
}
/** 重写父类的设置frame函数 **/
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    Calendar_Width = frame.size.width;
    Calendar_DayWidth = (Calendar_Width-6)/7;
}
/** 重写父类初始化函数 **/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    Calendar_Width = frame.size.width;
    Calendar_DayWidth = (Calendar_Width-6)/7;
    if (self) {
        [self initDefault];
    }
    return self;
}
//自定义初始化函数
- (void)initDefault{
    // 设置视图控件背景颜色透明
    self.backgroundColor = [UIColor clearColor];
    // 设置为模型，始终靠上方
    self.contentMode = UIViewContentModeTop;
    // 超出绘制区域时隐藏起来
    self.clipsToBounds=YES;
    //日期显示
    _secMonthLable = [[UILabel alloc] initWithFrame:CGRectMake(34, 10, Calendar_Width-68, 30)];
    [_secMonthLable setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    [_secMonthLable setBackgroundColor:[UIColor clearColor]];
    [_secMonthLable setTextColor:[UIColor whiteColor]];
    [_secMonthLable setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_secMonthLable];
    //获取当前日期
    _currDate = [NSDate date];
    //默认选中当前日期
    _secDate = _currDate;
    [self setFrameHeight:self.calendarHeight];
}
//设置当前frame的新高度
- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            self.frame.size.width, newHeight);
}
//获取当前的日历高度
-(float)getCalendarHeight {
    return Calendar_TopBarHeight + NumRows*(Calendar_DayHeight+2)+2;
}


/** 重写父类绘图函数 **/
- (void)drawRect:(CGRect)rect{
    //    [self test3];
    //获取画板
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //绘制月导航
    [self drawRectArrow:rect context:context];
    //绘制周
    [self drawRectWeek:rect context:context];
    //绘制日期标记
    [self drawRectDateMark:rect context:context];
    //绘制日期数字
    [self drawRectDateNumber:rect context:context];
}

//绘制TOP导航
-(void)drawRectArrow:(CGRect)rect context:(CGContextRef)context{
    //当前选择的月
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月"];
    [_secMonthLable setText:[fmt stringFromDate:_currDate]];
    
    //左右箭头的绘制
    CGRect rectangle = CGRectMake(0,0,self.frame.size.width,Calendar_TopBarHeight);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 14;
    int xmargin = 20;
    int ymargin = 18;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextFillPath(context);
}
//绘制周
-(void)drawRectWeek:(CGRect)rect context:(CGContextRef)context{
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEE";
    //当前的语言
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortWeekdaySymbols]];
    CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    for (int i =0; i<[weekdays count]; i++) {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        [weekdayValue drawInRect:CGRectMake(i*(Calendar_DayWidth+2), 40, Calendar_DayWidth+2, 20) withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    }
    CGContextSetAllowsAntialiasing(context, NO);
}

//绘制日期数字
-(void)drawRectDateNumber:(CGRect)rect context:(CGContextRef)context{
    long firstWeekDay = [MyCalendarTool getFirstWeekDayInMonth:_currDate];
    
    NSDate *previousMonth = [self getOffsetMonth:_currDate numMonths:-1];
    long currentMonthNumDays = [MyCalendarTool getNumDaysInMonth:_currDate];
    long prevMonthNumDays = [MyCalendarTool getNumDaysInMonth:previousMonth];
    long selectedDateBlock = _secDate ? ([[self getComponentsForDate:_secDate] day]-1 + firstWeekDay) : -1;
    //获取当前日期
    NSDate *todayDate = [NSDate date];
    //算出当前日期所在的格子位置
    long todayBlock = -1;
    if ([[self getComponentsForDate:todayDate] month] == [[self getComponentsForDate:_currDate] month] && [[self getComponentsForDate:todayDate] year] == [[self getComponentsForDate:_currDate] year]) {
        todayBlock = [[self getComponentsForDate:todayDate] day] + firstWeekDay - 1;
    }
    
    //设置文字颜色
    CGContextSetFillColorWithColor(context,[UIColor blackColor].CGColor);
    
    for (int i=0; i<NumBlocks; i++) {
        long targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (Calendar_DayWidth+2);
        int targetY = Calendar_TopBarHeight + targetRow * (Calendar_DayHeight+2);
        
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) {
            //上一个月
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
            // [UIColor colorWithRed:56/255.0f green:56/255.0f blue:56/255.0f alpha:1.0f] 0x383838
            // [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f]
            CGContextSetFillColorWithColor(context,[UIColor grayColor].CGColor);
        } else if (i>=(firstWeekDay+currentMonthNumDays)) {
            //下个月
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
            CGContextSetFillColorWithColor(context,[UIColor grayColor].CGColor);
        } else {
            //当前月
            targetDate = (i-firstWeekDay)+1;
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        }
        
        NSString *dateNumber = [NSString stringWithFormat:@"%ld",targetDate];
        
        //绘制底部背景方格
        if (_secDate && i==selectedDateBlock) { //如果是选中日期
            //绘制选择日期的底部圆
            CGContextAddArc(context, targetX+Calendar_DayWidth/2, targetY+2+Calendar_DayHeight/2, Calendar_DayWidth/4, 0, 2*PI, 0);
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextFillPath(context);
            //绘制完方格后设置画笔颜色为白色，以绘制选择日期的文字颜色
            CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
        } else if (todayBlock==i) {             //如果是当天日期
            //绘制当天日期的底部圆
            CGContextAddArc(context, targetX+Calendar_DayWidth/2, targetY+2+Calendar_DayHeight/2, Calendar_DayWidth/4, 0, 2*PI, 0);
            CGContextSetFillColorWithColor(context, [UIColor colorWithRed:56/255.0f green:56/255.0f blue:56/255.0f alpha:1.0f].CGColor);
            CGContextSetLineWidth(context, 1.5);//线的宽度
            CGContextDrawPath(context, kCGPathStroke);
            //绘制完方格后设置画笔颜色为白色，以绘制当天日期的文字颜色
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        }
        //绘制日期数字
        [dateNumber drawInRect:CGRectMake(targetX, targetY+10, Calendar_DayWidth, Calendar_DayHeight) withFont:[UIFont boldSystemFontOfSize:17] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    }
    
}

-(void)drawRectDateMark:(CGRect)rect context:(CGContextRef)context{
    //如果没有标记日期，返回
    if (!_markDay) return;
    //当前月的第一天是星期几
    long firstWeekDay = [MyCalendarTool getFirstWeekDayInMonth:_currDate];
    //获取日历控件第一格显示的日期和最后一格显示的日期
    NSString * showFirstDayStr = [self getShowFirstDay];
    NSString * showLastDayStr = [self getShowLastDay];
    
    for (int i = 0; i<[_markDay count]; i++) {
        NSString *markDayStr = [_markDay objectAtIndex:i];
        //如果日期在视图显示的范围内
        if([showFirstDayStr compare:markDayStr]!=NSOrderedDescending && [showLastDayStr compare:markDayStr]!=NSOrderedAscending){
            NSLog(@"markDayStr=%@", markDayStr);
        }else{
            continue;
        }
        NSDate *markDate = [MyCalendarTool getDateFromStr:markDayStr formatStr:@"yyyy-MM-dd"];
        //算出当前日期所在格子的索引
        long targetBlock = -1;
        //如果日期等于当前的年月
        if ([[self getComponentsForDate:markDate] month] == [[self getComponentsForDate:_currDate] month] && [[self getComponentsForDate:markDate] year] == [[self getComponentsForDate:_currDate] year]) {
            targetBlock = [[self getComponentsForDate:markDate] day] + firstWeekDay - 1;
        }
        
        
        
        int targetColumn = targetBlock%7;
        long targetRow = targetBlock/7;
        
        int targetX = targetColumn * (Calendar_DayWidth+2);
        long targetY = Calendar_TopBarHeight + targetRow * (Calendar_DayHeight+2);
        
        
        //绘制标记日期的底部圆
        CGContextAddArc(context, targetX+Calendar_DayWidth/2, targetY+2+Calendar_DayHeight/2, Calendar_DayWidth/4, 0, 2*PI, 0);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextFillPath(context);
    }
}
-(NSString*)getShowFirstDay{
    //当前月的第一天是星期几
    long firstWeekDay = [MyCalendarTool getFirstWeekDayInMonth:_currDate];
    //获取日历控件第一格显示的日期
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate: _currDate];
    [comps setDay:1];
    if(firstWeekDay>0){
        [comps setDay:1-firstWeekDay];
    }
    NSDate *showFirstDate = [calendar dateFromComponents:comps];
    NSString *showFirstDateStr = [MyCalendarTool getStrFromDate:showFirstDate];
    NSLog(@"showFirstDate=%@", showFirstDateStr);
    return showFirstDateStr;
}
-(NSString*)getShowLastDay{
    //当前月的第一天是星期几
    long firstWeekDay = [MyCalendarTool getFirstWeekDayInMonth:_currDate];
    //当前月的总日数
    long currentMonthNumDays = [MyCalendarTool getNumDaysInMonth:_currDate];
    //格子的总数目
    long targetDate = NumBlocks - (firstWeekDay+currentMonthNumDays);
    //获取日历控件最后一格显示的日期
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate: _currDate];
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    [comps setDay:[comps day]+targetDate];
    NSDate *showLastDate = [calendar dateFromComponents:comps];
    NSString *showLastDateStr = [MyCalendarTool getStrFromDate:showLastDate];
    NSLog(@"showLastDate=%@", showLastDateStr);
    return showLastDateStr;
}
//用一个日期获取当前Components对象
-(NSDateComponents *)getComponentsForDate:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return comp;
}
//根据偏移量获取一个日期
-(NSDate *)getOffsetMonth:(NSDate *)date numMonths:(int)numMonths{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];//monday is first day
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents toDate:date options:0];
}

/**
 *  处理日历视图控件的点击事件
 */
/** 重写UIView点击事件的函数 **/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    //如果点击的区域是日期文字区域
    if (touchPoint.y > Calendar_TopBarHeight) {
        float xLocation = touchPoint.x;
        float yLocation = touchPoint.y-Calendar_TopBarHeight;
        
        int column = floorf(xLocation/(Calendar_DayWidth+2));
        int row = floorf(yLocation/(Calendar_DayHeight+2));
        
        int blockNr = (column+1)+row*7;
        long firstWeekDay = [MyCalendarTool getFirstWeekDayInMonth:_currDate];
        NSInteger date = blockNr-firstWeekDay;
        [self selectDate:date];
        return;
    }
    
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //如果点击的是箭头区域
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showChangeAnimating:-1];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showChangeAnimating:1];
    } else if (CGRectContainsPoint(_secMonthLable.frame, touchPoint)) {
        self.currDate = [NSDate date];
        self.secDate = _currDate;
        [self setFrameHeight:self.calendarHeight];
        [self setNeedsDisplay];
        
        //调用接口中选择日期的函数
        if (self.delegate && [self.delegate respondsToSelector:@selector(MyCalendarView:dateSelected:)]) {
            [self.delegate MyCalendarView:self dateSelected:_secDate];
        }
    }
    
}
//点击日期的处理函数
-(void)selectDate:(NSInteger)day{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay fromDate:_currDate];
    [comps setDay:day];
    self.secDate = [gregorian dateFromComponents:comps];
    
    NSDateComponents *currComp = [self getComponentsForDate:_currDate];
    NSDateComponents *secComp = [self getComponentsForDate:_secDate];
    
    if ([secComp year]<[currComp year] || ([secComp year]==[currComp year] && [secComp month]<[currComp month])) {
        //上一月
        [self showChangeAnimating:-1];
    }else if([secComp year]>[currComp year] || ( [secComp year]==[currComp year] && [secComp month]>[currComp month])){
        //下一月
        [self showChangeAnimating:1];
    }else{
        [self setNeedsDisplay];
    }
    
    //调用接口中选择日期的函数
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyCalendarView:dateSelected:)]) {
        [self.delegate MyCalendarView:self dateSelected:_secDate];
    }
}
//切换上下月动画
-(void)showChangeAnimating:(int)type{
    static BOOL isAnimating = NO;
    //如果已经在执行动画了则直接跳出
    if (isAnimating)  return;
    isAnimating = YES;
    
    //获取当前的页面
    float oldSize = self.calendarHeight;
    UIImageView *animatViewA = [[UIImageView alloc] initWithImage:[self getCurrentDrawState]];
    
    //切换月状态
    self.currDate = [self getOffsetMonth:_currDate numMonths:type];
    [self setFrameHeight:self.calendarHeight];
    [self setNeedsDisplay];
    UIImageView *animatViewB = [[UIImageView alloc] initWithImage:[self getCurrentDrawState]];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *antimatView = [[UIView alloc] initWithFrame:CGRectMake(0, Calendar_TopBarHeight, Calendar_Width, targetSize-Calendar_TopBarHeight)];
    [antimatView setClipsToBounds:YES];
    [self addSubview:antimatView];
    
    [antimatView addSubview:animatViewA];
    [antimatView addSubview:animatViewB];
    
    CGFloat starPiont = 0;
    CGFloat endPiont = 0;
    if (type == 1) {
        //下一月
        starPiont = animatViewA.frame.origin.x + animatViewB.frame.size.width+3;
        endPiont = animatViewA.frame.origin.x - animatViewA.frame.size.width+3;
    }else{
        //上一月
        starPiont = animatViewA.frame.origin.x-animatViewB.frame.size.width+3;
        endPiont = animatViewB.frame.size.width-3;
    }
    
    //初始化动画坐标-设置默认位置
    [self setFrameForView:animatViewB frameX:starPiont];
    [self setFrameHeight:oldSize];
    
    [UIView animateWithDuration:.50
                     animations:^{
                         [self setFrameHeight:self.calendarHeight];
                         [self setFrameForView:animatViewA frameX:endPiont];
                         [self setFrameForView:animatViewB frameX:0];
                     }
                     completion:^(BOOL finished) {
                         isAnimating=NO;
                         [antimatView removeFromSuperview];
                     }
     ];
}
//获取当前月第一天
//-(NSDate *)getFirstDayForDate:(NSDate *)date{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
//    NSInteger day = [dayComponents day];//当前天
//
//    //计算获取新date
//    NSDateComponents *compToAdd = [[NSDateComponents alloc] init];
//    [compToAdd setDay:-day+1];
//    NSDate *nDate = [calendar dateByAddingComponents:compToAdd toDate:date options:0];
//
//    return nDate;
//}
//获取当前绘制的状态转存为图片
-(UIImage *)getCurrentDrawState{
    float targetHeight = Calendar_TopBarHeight + NumRows*(Calendar_DayHeight+2)+1;
    UIGraphicsBeginImageContext(CGSizeMake(Calendar_Width, targetHeight-Calendar_TopBarHeight));
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -Calendar_TopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage *tmpImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tmpImg;
}
//设置x轴
- (void)setFrameForView:(UIView *)view frameX:(CGFloat)frameX{
    view.frame = CGRectMake(frameX, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}
//设置Y轴
- (void)setFrameForView:(UIView *)view frameY:(CGFloat)frameY{
    view.frame = CGRectMake(view.frame.origin.x, frameY, view.frame.size.width, view.frame.size.height);
}

@end
