//
//  UIScrollView+YunisRefresh.m
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/29.
//  Copyright © 2015年 yunis. All rights reserved.
//

#import "UIScrollView+YunisRefresh.h"
#import "YunisHeardView.h"
#import <objc/runtime.h>
@interface UIScrollView()
@property (weak, nonatomic) YunisHeardView *header;
@end
@implementation UIScrollView (YunisRefresh)
static char MJRefreshHeaderViewKey;
static char MJRefreshFooterViewKey;
- (void)setHeader:(YunisHeardView *)header {
    [self willChangeValueForKey:@"MJRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &MJRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"MJRefreshHeaderViewKey"];
}

- (YunisHeardView *)header {
    return objc_getAssociatedObject(self, &MJRefreshHeaderViewKey);
}
- (void)addHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.header) {
        YunisHeardView *header = [YunisHeardView new];
        [header addTarget:self action:@selector(backItemTest) forControlEvents:UIControlEventValueChanged];
        [self addSubview:header];
        self.header = header;
    }
    
    // 2.设置block回调
//    self.header.beginRefreshingCallback = callback;
}
- (void)backItemTest{
    NSLog(@"ttttttttttttt");
}
- (void)headerEndRefreshing
{
    [self.header endRefreshing];
}
@end
