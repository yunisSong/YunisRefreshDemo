//
//  RoundAnimationView.h
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/30.
//  Copyright © 2015年 yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundAnimationView : UIView
@property (nonatomic,assign) CGFloat progress;/**<进度*/
@property (nonatomic,assign,getter=isRefreshing) BOOL refreshing;/**<是否刷新中*/
@end
