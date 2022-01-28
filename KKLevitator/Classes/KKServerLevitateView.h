//
//  KKServerLevitateView.h
//  MyPratice
//
//  Created by BYMac on 2021/12/8.
//

#import <UIKit/UIKit.h>
@class KKServerLevitateView;
NS_ASSUME_NONNULL_BEGIN

@protocol KKServerLevitateViewDelegate <NSObject>
- (void)serverLevitateView:(KKServerLevitateView *)serverLevitateView didSwitchServerWithIdx:(NSInteger)idx title:(NSString *)title;
@end

@interface KKServerLevitateView : UIView

/// 服务器
@property (nonatomic, strong) NSArray * servers;

/// 信息标签
@property (nonatomic, strong) UILabel * infoLabel;

@property (nonatomic, weak) id<KKServerLevitateViewDelegate>delegate;

/// 主动显示重启提示框
- (void)showRestartAlert;
@end

NS_ASSUME_NONNULL_END
