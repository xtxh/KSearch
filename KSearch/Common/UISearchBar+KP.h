//
//  UISearchBar+KP.h
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (KP)

//搜索文字字体
-(void)setTextFont:(UIFont*)font;

//搜索文字颜色
-(void)setTextColor:(UIColor*)textColor;

//取消文字
-(void)setCancelText:(NSString*)cancelText;

//设置富文本占位文字
-(void)setAttributesPlaceholder:(NSMutableAttributedString*)attributePlaceholder;

//取消文字字体
-(void)setCancelTextFont:(UIFont*)font;

//取消文字属性:color,font,...
-(void)setCancelButtonTitleAttributes:(NSDictionary*)attributes;

-(void)setPlaceholderAlignmentCenter;


@end
