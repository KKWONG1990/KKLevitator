//
//  KKSuspendedLayer.h
//  MyPratice
//
//  Created by BYMac on 2021/12/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KKLevitator : NSObject

/// 实例化悬浮者
/// @param levitateView 悬浮层
- (instancetype)initWithLevitateView:(UIView *)levitateView;

/// 实例化悬浮者
/// @param levitateView 悬浮层
+ (instancetype)levitatorWithLevitateView:(UIView *)levitateView;

/// 悬浮控件父视图
@property (nonatomic, strong, readonly) UIView * container;

/// 悬浮控件视图
@property (nonatomic, strong, readonly) UIView * levitateView;

/// levitateView的初始点 - 默认在右边的中间
@property (nonatomic) CGPoint point;

/// 悬浮层是否可以被拖动，默认NO
@property (nonatomic, getter=isCanMove) BOOL canMove;

/// 显示浮层到默认视图 - keywindow
- (void)show;

/// 显示浮层到指定的视图
/// @param container 视图
- (void)showInContainer:(UIView *)container;

/// 移除浮层
- (void)remove;
@end

NS_ASSUME_NONNULL_END

