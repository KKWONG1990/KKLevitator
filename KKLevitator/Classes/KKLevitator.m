//
//  KKSuspendedLayer.m
//  MyPratice
//
//  Created by BYMac on 2021/12/6.
//

#import "KKLevitator.h"
#import "Aspects.h"

@interface KKLevitator()
@property (nonatomic, strong) UIView * container;
@property (nonatomic, strong) UIView * levitateView;
@property (nonatomic, strong) UIPanGestureRecognizer * panGR;
@end

@implementation KKLevitator

- (instancetype)initWithLevitateView:(UIView *)levitateView {
    self = [super init];
    if (self) {
        [self initSetup:levitateView];
    }
    return self;
}

+ (instancetype)levitatorWithLevitateView:(UIView *)levitateView {
    return [[self alloc] initWithLevitateView:levitateView];
}

- (void)initSetup:(UIView *)levitateView {
    if (levitateView) {
        self.levitateView = levitateView;
        CGSize size = levitateView.frame.size;
        CGPoint point = CGPointMake([self maxX], [self startY]);
        self.levitateView.frame = CGRectMake(point.x, point.y, size.width, size.height);
        [self.levitateView addGestureRecognizer:self.panGR];
    }
}

//添加视图到父视图
- (void)addlevitateViewToContainer:(UIView *)container {
    if ([container.subviews containsObject:self.levitateView]) return;
    [container addSubview:self.levitateView];
    __weak typeof(self) weakSelf = self;
    [container aspect_hookSelector:@selector(addSubview:) withOptions:AspectPositionAfter usingBlock:^{
        [container bringSubviewToFront:weakSelf.levitateView];
    } error:NULL];
}

//设置视图的位置
- (void)layoutWithRect:(CGRect)rect duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.levitateView.frame = rect;
    }];
}

- (void)dealloc {
    if ([self.container.subviews containsObject:self.levitateView]) {
        [self.levitateView removeFromSuperview];
    }
}

#pragma mark - UIPanGestureRecognizer action
- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan {
    CGPoint panPoint = [pan locationInView:self.container];
    CGPoint finalPoint = [self final:CGPointMake(panPoint.x - [self halfWidth], panPoint.y - [self halfHeight]) state:pan.state];
    NSTimeInterval duration = pan.state == UIGestureRecognizerStateEnded ? 0.5 : 0.0;
    [self layoutWithRect:CGRectMake(finalPoint.x, finalPoint.y, CGRectGetWidth(self.levitateView.frame), CGRectGetHeight(self.levitateView.frame)) duration:duration];
}

/// 获取最终的点位置
/// @param point UIPanGestureRecognizer point
/// @param state UIGestureRecognizerState
- (CGPoint)final:(CGPoint)point state:(UIGestureRecognizerState)state{
    CGPoint finalPoint = point;
    if (state == UIGestureRecognizerStateEnded) {
        finalPoint.x = point.x < CGRectGetWidth(UIScreen.mainScreen.bounds) / 2 ? [self minX] : [self maxX];
    } else {
        finalPoint.x = [self isBeyondMaxX:point] ? [self maxX] : [self finalX:point];
    }
    finalPoint.y = [self finalY:point];
    return finalPoint;
}

//最小的X点
- (CGFloat)minX {
    return 0;
}

//最大的X点
- (CGFloat)maxX {
    return CGRectGetWidth(UIScreen.mainScreen.bounds) - CGRectGetWidth(self.levitateView.frame);
}

//最小的Y点
- (CGFloat)minY {
    CGFloat top = 0;
    if (@available(iOS 11.0, *)) {
        top = UIApplication.sharedApplication.delegate.window.safeAreaInsets.top;
    }
    return top;
}

//最大的Y点
- (CGFloat)maxY {
    CGFloat bottom = 0;
    if (@available(iOS 11.0, *)) {
        bottom = UIApplication.sharedApplication.delegate.window.safeAreaInsets.bottom;
    }
    return CGRectGetHeight(UIScreen.mainScreen.bounds) - CGRectGetHeight(self.levitateView.frame) - bottom;
}

- (CGFloat)startY {
    return CGRectGetHeight(UIScreen.mainScreen.bounds) / 2 - CGRectGetHeight(self.levitateView.frame) / 2;
}

//最终的Y点
- (CGFloat)finalX:(CGPoint)point {
    return point.x > 0.0 ? point.x : 0.0;
}

//最终的Y点
- (CGFloat)finalY:(CGPoint)point {
    if (point.y < [self minY]) {
        return [self minY];
    } else if (point.y > [self maxY]) {
        return [self maxY];
    } else {
        return point.y;
    }
}

//一半宽度
- (CGFloat)halfWidth {
    return CGRectGetWidth(self.levitateView.frame) / 2;
}

//一半高度
- (CGFloat)halfHeight {
    return CGRectGetHeight(self.levitateView.frame) / 2;
}

//是否超过最大X点
- (BOOL)isBeyondMaxX:(CGPoint)point {
    return !CGRectContainsPoint(UIScreen.mainScreen.bounds, CGPointMake(point.x + CGRectGetWidth(self.levitateView.frame), point.y));
}

#pragma mark - public methond
- (void)show {
    [self addlevitateViewToContainer:self.container];
}

- (void)showInContainer:(UIView *)container {
    self.container = container;
    [self addlevitateViewToContainer:self.container];
}

- (void)remove {
    if ([self.container.subviews containsObject:self.levitateView]) {
        [self.levitateView removeFromSuperview];
    }
}

#pragma mark setter / getter
- (UIPanGestureRecognizer *)panGR {
    if (!_panGR) {
        _panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
        _panGR.enabled = self.isCanMove;
    }
    return _panGR;
}

- (void)setPoint:(CGPoint)point {
    _point = [self final:point state:UIGestureRecognizerStateBegan];
    if (self.container) {
        [self layoutWithRect:CGRectMake(_point.x, _point.y, CGRectGetWidth(self.levitateView.frame), CGRectGetHeight(self.levitateView.frame)) duration:0.0];
    }
}

- (void)setCanMove:(BOOL)canMove {
    _canMove = canMove;
    self.panGR.enabled = canMove;
}

- (UIView *)container {
    if (!_container) {
        _container = UIApplication.sharedApplication.delegate.window;
    }
    return _container;
}

@end
