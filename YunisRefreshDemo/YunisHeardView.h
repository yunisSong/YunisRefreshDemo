//
//  YunisHeardView.h
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/29.
//  Copyright © 2015年 yunis. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RefreshType) {
    YunisRefreshType_nomore,

    YunisRefreshType_ready,
    YunisRefreshType_refreshing,
};
@interface YunisHeardView : UIControl

- (void)addHeardToScrollowView:(UIScrollView *)scrollView;

- (void)beginRefreshing;

- (void)endRefreshing;
@end
