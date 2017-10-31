//
//  NSString+KP.h
//  WeChatSearch
//
//  Created by 柯平 on 2017/10/27.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KP)

/**
 计算文本高度
 
 @param font 字体
 @param width 约束宽度
 */
-(CGFloat)heightWithFont:(UIFont*)font constrainedToWidth:(CGFloat)width;

/**
 计算文本宽度
 
 @param font 字体
 @param height 约束高度
 */
-(CGFloat)widthWithFont:(UIFont*)font constrainedToHeight:(CGFloat)height;

/**
 计算文本大小
 
 @param font 字体
 @param width 约束高度
 */
-(CGSize)sizeWithFont:(UIFont*)font constrainedToWidth:(CGFloat)width;

/**
 计算文本大小
 
 @param font 字体
 @param height 约束高度
 */
-(CGSize)sizeWithFont:(UIFont*)font constrainedToHeight:(CGFloat)height;

/**
 计算文本大小
 
 @param font 字体
 @param size 约束区域
 */
-(CGRect)rectWithFont:(UIFont*)font constrainedToSize:(CGSize)size;

@end
