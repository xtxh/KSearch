//
//  KSearchItem.h
//  KSearch
//
//  Created by 柯平 on 2017/10/24.
//  Copyright © 2017年 柯平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KSearchType) {
    KSearchTypeInput,   //文字
    KSearchTypeVoice    //语音
};

typedef NS_ENUM(NSInteger,KSearchItemType) {
    KSearchItemApplet = 0,  //小程序
    KSearchItemCycle,       //圈子
    KSearchItemNews,        //资讯
    KSearchItemSubscribe,   //公众号
    KSearchItemStory,       //小说
    KSearchItemMusic,       //音乐
    KSearchItemEmoji        //表情
};

@interface KSearchItem : NSObject

/**/
@property(nonatomic,assign)KSearchItemType type;
/**/
@property(nonatomic,copy)NSString* itemImg;
/**/
@property(nonatomic,copy)NSString* itemTitle;
/**/
@property(nonatomic,copy)NSString* linkUrl;


@end
