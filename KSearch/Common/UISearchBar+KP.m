//
//  UISearchBar+KP.m
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import "UISearchBar+KP.h"
#import <YYKit.h>
#import "NSString+KP.h"

@implementation UISearchBar (KP)

-(void)setTextFont:(UIFont *)font
{
    if (@available(iOS 9.0, *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    } else {
        [UITextField appearanceWhenContainedIn:[UISearchBar class], nil].font = font;
    }
}

-(void)setTextColor:(UIColor *)textColor
{
    if (@available(iOS 9.0, *)) {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    } else {
        [UITextField appearanceWhenContainedIn:[UISearchBar class], nil].textColor = textColor;
    }
}

-(void)setAttributesPlaceholder:(NSMutableAttributedString *)attributePlaceholder
{
    if (@available(iOS 9.0, *)) {
        [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setAttributedPlaceholder:attributePlaceholder];
    }else{
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAttributedPlaceholder:attributePlaceholder];
    }
}



-(void)setCancelText:(NSString *)cancelText
{
    if (@available(iOS 9.0, *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:cancelText];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:cancelText];
    }
}

-(void)setCancelTextFont:(UIFont *)font
{
    NSDictionary* attributes = @{NSFontAttributeName:font};
    if (@available(iOS 9.0, *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
}

-(void)setCancelButtonTitleAttributes:(NSDictionary *)attributes
{
    if (@available(iOS 9.0, *)) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
}

-(void)setPlaceholderAlignmentCenter
{
    NSString* placeholder = self.placeholder;
    if (![placeholder isNotBlank]) placeholder = @"搜索";
    BOOL avtive = self.isFirstResponder;
    BOOL showBookmark = self.showsBookmarkButton;
    CGRect frame = self.frame;
    CGFloat textWidth = [placeholder widthWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]] constrainedToHeight:34];
    if (avtive) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }else{
        if (showBookmark) {
            [self setPositionAdjustment:
             UIOffsetMake((frame.size.width-textWidth-53)/2.0, 0) forSearchBarIcon:UISearchBarIconSearch];
        }else{
            [self setPositionAdjustment:
             UIOffsetMake((frame.size.width-textWidth-53)/2.0, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
    
}

@end
