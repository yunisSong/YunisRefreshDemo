//
//  YunisHeardView.m
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/29.
//  Copyright © 2015年 yunis. All rights reserved.
//


#import "YunisHeardView.h"

#define MAS_SHORTHAND_GLOBALS
#import "RoundAnimationView.h"
#import "Masonry.h"



static const CGFloat beginRefresh = 70.f;

@interface YunisHeardView()
{
    BOOL firstTest;
}

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UILabel *stateLabel;

@property (strong, nonatomic) RoundAnimationView *showView;

@property(nonatomic)BOOL isShouldRefresh;/**<是否到达刷新位置*/
@property(nonatomic)BOOL isAlrdayRefresh;/**<正在刷新刷新位置*/
@property(nonatomic)RefreshType m_Type;
@end
@implementation YunisHeardView

#pragma mark - Life Cycle


/*
 
 1,监听scrollow 滑动距离，
 
 当滑动距离大于某个值 松开开始刷新
 
 需要判断是是否在滚动
 
 是否还在点击
 
 是否松开手
 
 传递当前滑动距离到视图进行视图改变 或者在本类控制效果改变
 
 同时scrollow悬停在某个位置
 
 
 manage 管理是否显示动画
 
 
 obj 接收时间：开始动画  结束动画
 
 动画形成层级  展示变化  形成视差  Twitter效果
 
 y轴
 
 
 
 */

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        self.scrollView = newSuperview;
        //    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self setFrame:CGRectMake(0.f, 0.f, _scrollView.frame.size.width, 0)];
        
        [self addSubview:self.stateLabel];
        
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.lessThanOrEqualTo(self);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(- 20);
            //        make.centerY.equalTo(self).offset(- 20);
        }];
        NSLog(@"ppp == %@",NSStringFromCGRect(self.stateLabel.frame));
        
        NSLog(@"ppp == %@",NSStringFromCGRect(self.frame));
//        [_scrollView addSubview:self];
//        self.backgroundColor = [UIColor redColor];
        
        
        self.showView = ({
            RoundAnimationView *t = [RoundAnimationView new];
            t;
        });
        
        [self addSubview:self.showView];
        
        [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.stateLabel);
            make.right.equalTo(self.stateLabel.mas_left).offset(- 10);
        }];
    }
}
- (void)dealloc
{
    
}
#pragma mark - Public Method
//外部方法
- (void)addHeardToScrollowView:(UIScrollView *)scrollView
{

    
    self.scrollView = scrollView;
//    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self setFrame:CGRectMake(0.f, 0.f, scrollView.frame.size.width, 0)];
    
    [self addSubview:self.stateLabel];

    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.lessThanOrEqualTo(self);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(- 20);
//        make.centerY.equalTo(self).offset(- 20);
    }];
    NSLog(@"ppp == %@",NSStringFromCGRect(self.stateLabel.frame));
    
    NSLog(@"ppp == %@",NSStringFromCGRect(self.frame));
    [scrollView addSubview:self];
    self.backgroundColor = [UIColor redColor];
}
- (void)beginRefreshing
{
    self.stateLabel.text = @"刷新中。。。";
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [UIView animateWithDuration:.5
                          delay:0.0
         usingSpringWithDamping:.5
          initialSpringVelocity:1
                        options:UIViewAnimationOptionTransitionCurlDown
                     animations:^{
                         [self.scrollView setContentInset:UIEdgeInsetsMake(beginRefresh, 0.f, 0.f, 0.f)];
                         [self.scrollView setContentOffset:CGPointMake(0.f, -beginRefresh) animated:YES];
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                     }];
    self.isAlrdayRefresh = YES;
}

- (void)endRefreshing
{

    self.showView.refreshing=NO;
    
    self.showView.progress=1.0f;
    [UIView animateWithDuration:.5
                          delay:0.0
         usingSpringWithDamping:.5
          initialSpringVelocity:1
                        options:UIViewAnimationOptionTransitionCurlDown
                     animations:^{
                         [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0.f, 0.f, 0.f)];
                         [self.scrollView setContentOffset:CGPointMake(0.f, 0) animated:YES];
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                     }];
    
     self.isAlrdayRefresh = NO;
    
    
    self.m_Type = YunisRefreshType_nomore;

    
}


#pragma mark - Private Method
//本类方法

#pragma mark - Delegate
//代理方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    if (self.m_Type == YunisRefreshType_refreshing) {
        return;
    }
    [self calculateShift];
}
-(void)calculateShift{
    
    [self setFrame:CGRectMake(0.f,
                              0.f,
                              self.scrollView.frame.size.width,
                              self.scrollView.contentOffset.y)];
    
    
    CGFloat offsetY=self.scrollView.contentOffset.y+self.scrollView.contentInset.top;
    
    CGFloat currentOffsetY = ABS(offsetY);
    
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = beginRefresh ;
    
    //进度条处理
    [self progressSetWithCurrentOffsetY:currentOffsetY happenOffsetY:happenOffsetY];
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        if (self.m_Type == YunisRefreshType_nomore && self.scrollView.contentOffset.y <= - beginRefresh) {
            // 转为即将刷新状态
            self.m_Type = YunisRefreshType_ready;
        } else if (self.m_Type == YunisRefreshType_ready && self.scrollView.contentOffset.y > - beginRefresh) {
            // 转为普通状态
            self.m_Type = YunisRefreshType_nomore;
        }
    } else if (self.m_Type == YunisRefreshType_ready) {// 即将刷新 && 手松开
        // 开始刷新
        self.m_Type = YunisRefreshType_refreshing;
    }

}
-(void)progressSetWithCurrentOffsetY:(CGFloat)currentOffsetY happenOffsetY:(CGFloat)happenOffsetY{
    
    
    if(currentOffsetY<=happenOffsetY){
        CGFloat deltaY= 40;
        CGFloat nowY=currentOffsetY-deltaY;
        self.showView.progress=.00001f;
        if(nowY<=0) return;
        
        //计算进度
        CGFloat progress=nowY/(happenOffsetY-deltaY);
        
        //异常处理
        if(progress<=0) progress=0.f;
        if(progress>=1) progress=1.f;
        
        
        self.showView.progress=progress;
        
    }else{
        
        self.showView.progress=1.0f;
    }
    
    
}
+(void)drawEllipse:(CGPoint)point withColor:(UIColor*)color withRad:(float)rad
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillEllipseInRect(ctx, CGRectMake(point.x-rad, point.y-rad, 2*rad, 2*rad));
}
#pragma mark - Event Response
//点击响应事件



#pragma mark - getters and setters
//初始化页面
- (UILabel *)stateLabel{
    if (_stateLabel == nil) {
        _stateLabel = ({
            UILabel *textLable               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            textLable.font                   = [UIFont systemFontOfSize:18];
            textLable.text                   = @"下拉刷新";
            textLable;
        });
    }
    
    return _stateLabel;
}

- (void)setM_Type:(RefreshType)m_Type
{
    _m_Type = m_Type;
    switch (_m_Type) {
        case YunisRefreshType_ready: {
            //准备刷新
            self.stateLabel.text = @"松开刷新";
            break;
        }
        case YunisRefreshType_refreshing: {
            //正在刷新
             self.stateLabel.text = @"刷新中。。。";
            [self beginRefreshing];
             self.showView.refreshing=YES;
            break;
        }
        case YunisRefreshType_nomore: {
            //还没有刷新
            
             self.stateLabel.text = @"下拉刷新";
            //通知showView开始刷新
            self.showView.refreshing=NO;
            break;
        }
        default: {
            break;
        }
    }
}
@end
