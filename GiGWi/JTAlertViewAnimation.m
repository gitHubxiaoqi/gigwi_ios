//
//  JTAlertViewAnimation.m
//  Qyli
//
//  Created by 小七 on 14-10-6.
//  Copyright (c) 2014年 ___清一丽___. All rights reserved.
//

#import "JTAlertViewAnimation.h"

@implementation JTAlertViewAnimation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
           }
    return self;
}
+(void)startAnimation:(NSString *)str view:(UIView *)view
{
    UILabel * lab=(UILabel *)[view viewWithTag:7777];
    UIScreen * screen=[UIScreen mainScreen];
    if (lab==nil)
    {
        lab=[[UILabel alloc] initWithFrame:CGRectMake(screen.bounds.size.width-200/2, screen.bounds.size.height, 200, 20)];
        [view addSubview:lab];
    }
    else
    {
        lab.frame=CGRectMake(screen.bounds.size.width-200/2, screen.bounds.size.height, 200, 20);
        lab.alpha=1;
        [view addSubview:lab];
    }
    lab.backgroundColor=[UIColor brownColor];
    lab.font=[UIFont systemFontOfSize:14];
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.tag=7777;
    lab.text=str;
    lab.numberOfLines=0;
    CGSize autoSize=[lab.text boundingRectWithSize:CGSizeMake(screen.bounds.size.width-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
    if (autoSize.height<20)
    {
        autoSize.height=20;
    }
    if (autoSize.width<100)
    {
        autoSize.width=100;
    }
    lab.frame=CGRectMake((screen.bounds.size.width-autoSize.width)/2-10, screen.bounds.size.height, autoSize.width+20, autoSize.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    lab.frame=CGRectMake((screen.bounds.size.width-autoSize.width)/2-10, screen.bounds.size.height-100,autoSize.width+20, autoSize.height);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelay:1.5];
    lab.alpha=0;
    [UIView commitAnimations];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
