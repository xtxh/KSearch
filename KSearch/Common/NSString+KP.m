//
//  NSString+KP.m
//  WeChatSearch
//
//  Created by 柯平 on 2017/10/27.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "NSString+KP.h"

@implementation NSString (KP)

-(CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    return [self sizeWithFont:font constrainedToWidth:width].height;
}
-(CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height{
    return [self sizeWithFont:font constrainedToHeight:height].width;
}
-(CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    return [self rectWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)].size;
}
-(CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height{
    return [self rectWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)].size;
}
- (CGSize)HeightForText:(NSString *)text withFontSize:(UIFont *)font withTextWidth:(CGSize)size
{
    // 获取文字字典
    NSDictionary *dict = @{NSFontAttributeName: font};//name="PingFangSC-Regular" family="PingFang SC" pointSize="14" [UIFont systemFontOfSize:fontSize]
    // 设定最大宽高
    CGSize sz = size;//CGSizeMake(textWidth, CGFLOAT_MAX);
    // 计算文字Frame
    CGRect frame = [text boundingRectWithSize:sz options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size;
}

-(CGRect)rectWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    UIFont* textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect rect;
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary* attributes = @{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:paragraph};
    rect = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect;
}

@end
