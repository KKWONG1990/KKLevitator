//
//  KKServerLevitateView.m
//  MyPratice
//
//  Created by BYMac on 2021/12/8.
//

#import "KKServerLevitateView.h"
@interface KKServerLevitateView()

@property (nonatomic, strong) UIButton * btn;
@property (nonatomic) BOOL showing;
@end
@implementation KKServerLevitateView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.infoLabel];
        [self addSubview:self.btn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.infoLabel.frame = self.bounds;
    self.btn.frame = self.bounds;
}

- (void)switchAction {
    if (self.showing) return;
    [self showAlertVC];
}

- (void)showAlertVC {
    self.showing = YES;
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"服务器" message:@"选择您要切换的服务器" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.showing = NO;
    }];
    [self.servers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction * action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(serverLevitateView:didSwitchServerWithIdx:title:)]) {
                [self.delegate serverLevitateView:self didSwitchServerWithIdx:[self.servers indexOfObject:action.title] title:action.title];
            }
            self.showing = NO;
        }];
        [alertVC addAction:action];
    }];
    [alertVC addAction:cancleAction];
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)showRestartAlert {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"切换服务器成功，需要重新启动才能生效" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    [alertVC addAction:action];
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel.textColor = UIColor.darkTextColor;
    }
    return _infoLabel;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        _btn.backgroundColor = UIColor.clearColor;
        [_btn addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
