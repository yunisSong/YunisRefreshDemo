//
//  UIScrollView+YunisRefresh.h
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/29.
//  Copyright © 2015年 yunis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YunisRefresh)
- (void)addHeaderWithCallback:(void (^)())callback;

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing;
@end
