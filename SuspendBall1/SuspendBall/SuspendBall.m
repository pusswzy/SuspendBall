//
//  SuspendBall.m
//
//  Created by 李昊泽 on 16/12/5.
//

#import "SuspendBall.h"

/*** 分类方法  ***/
@interface UIView (Extension)
@property (nonatomic, assign) CGFloat lhz_width;
@property (nonatomic, assign) CGFloat lhz_height;

@property (nonatomic, assign) CGFloat lhz_x;
@property (nonatomic, assign) CGFloat lhz_y;

@property (nonatomic, assign) CGFloat lhz_centerX;
@property (nonatomic, assign) CGFloat lhz_centerY;
@end

@implementation UIView (Extension)

- (CGFloat)lhz_width
{
    return self.frame.size.width;
}

- (CGFloat)lhz_height
{
    return self.frame.size.height;
}

- (void)setLhz_width:(CGFloat)lhz_width
{
    CGRect frame = self.frame;
    frame.size.width = lhz_width;
    self.frame = frame;
}

- (void)setLhz_height:(CGFloat)lhz_height
{
    CGRect frame = self.frame;
    frame.size.height = lhz_height;
    self.frame = frame;
}

- (CGFloat)lhz_x
{
    return self.frame.origin.x;
}

- (void)setLhz_x:(CGFloat)lhz_x
{
    CGRect frame = self.frame;
    frame.origin.x = lhz_x;
    self.frame = frame;
}

- (CGFloat)lhz_y
{
    return self.frame.origin.y;
}

- (void)setLhz_y:(CGFloat)lhz_y
{
    CGRect frame = self.frame;
    frame.origin.y = lhz_y;
    self.frame = frame;
}

- (CGFloat)lhz_centerX
{
    return self.center.x;
}

- (void)setLhz_centerX:(CGFloat)lhz_centerX
{
    CGPoint center = self.center;
    center.x = lhz_centerX;
    self.center = center;
}


- (CGFloat)lhz_centerY
{
    return self.center.y;
}

- (void)setLhz_centerY:(CGFloat)lhz_centerY
{
    CGPoint center = self.center;
    center.y = lhz_centerY;
    self.center = center;
}
@end


/*** 悬浮球的实现  ***/
@interface SuspendBall ()<UIGestureRecognizerDelegate> {
    
}
@end
@implementation SuspendBall
static CGFloat fullButtonWidth    = 50;
static CGFloat btnBigImageWidth   = 32;
static CGFloat btnSmallImageWidth = 22;

///!!!: TO DO --- 以后会加上对横屏的支持 2018.11.28
#define KScreenWidth MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define KScreenHeight MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define IS_IPHONEX ((KScreenHeight == 812.f || KScreenHeight == 896.f) ? YES : NO)
#define KNavBarHeight (IS_IPHONEX ? 88.f:64.f)


#pragma mark - initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        self.layer.cornerRadius = fullButtonWidth / 2;
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
        [self setImage:[self resizeImage:[UIImage imageNamed:@"circle"] wantSize:CGSizeMake(btnBigImageWidth, btnBigImageWidth)] forState:0];
        [self addTarget:self action:@selector(suspendBallShow) forControlEvents:UIControlEventTouchUpInside];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveSuspend:)];
        pan.delegate = self;
        pan.delaysTouchesBegan = NO;
        [self addGestureRecognizer:pan];
        [self suspendBallShow];
        
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"%@---%@", gestureRecognizer.view, otherGestureRecognizer.view);
    return NO;
}

+ (instancetype)suspendBallWithFrame:(CGRect)ballFrame delegate:(id<SuspendBallDelegte>)delegate subBallImageArray:(NSArray *)imageArray
{
    SuspendBall *suspendBall = [[SuspendBall alloc] init];
    suspendBall.frame = ballFrame;
    suspendBall.delegate = delegate;
    suspendBall.imageNameGroup = imageArray;
    return suspendBall;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self suspendBallShow];
}

- (void)initialization
{
    _imageNameGroup = @[@"up", @"down"];
    _superBallBackColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    _showFunction = YES;
    _stickToScreen = YES;
}

- (void)setImageNameGroup:(NSArray *)imageNameGroup
{
    _imageNameGroup = imageNameGroup;
    _functionMenu = nil;
    
}

- (void)setSuperBallBackColor:(UIColor *)superBallBackColor
{
    _superBallBackColor = superBallBackColor;
    self.backgroundColor = superBallBackColor;
}

#pragma mark - Selector
//移动悬浮球  在这里添加对悬浮球的边界判断以及是否需要粘性效果
- (void)moveSuspend:(UIPanGestureRecognizer *)pan
{
    
    CGPoint point = [pan locationInView:self.superview];
    self.lhz_centerX = point.x;
    self.lhz_centerY = point.y;
    
    switch (pan.state) {
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if (point.x < fullButtonWidth / 2) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.lhz_x = 0;
                }];
            }
            
            if ( point.x > KScreenWidth - fullButtonWidth / 2 ) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.lhz_x = KScreenWidth - fullButtonWidth;
                }];
            }
            
            if (point.y > KScreenHeight - fullButtonWidth / 2) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.lhz_y = KScreenHeight - fullButtonWidth;
                }];
            }
            
            if (point.y < KNavBarHeight + fullButtonWidth / 2) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.lhz_y = KNavBarHeight;
                }];
            }
            
            [self judgeLeftOrRight:pan];
            break;
            
        default:
            break;
    }
}

- (void)suspendBallShow
{
    [self addAnimate:_showFunction];
    
    __weak typeof(self) weakSelf = self;
    if (_showFunction == NO) {
        self.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.6];
        [self setImage:[self resizeImage:[UIImage imageNamed:@"cross"] wantSize:CGSizeMake(btnSmallImageWidth, btnSmallImageWidth)] forState:0];
        _showFunction = YES;
        
        [self functionMenuShow];
        
        if (weakSelf.show) {
            weakSelf.show(_showFunction);
        }
        return;
        
    } else if (_showFunction == YES) { //full state
        self.backgroundColor = _superBallBackColor;
        [self setImage:[self resizeImage:[UIImage imageNamed:@"circle"] wantSize:CGSizeMake(btnBigImageWidth, btnBigImageWidth)] forState:0];
        _showFunction = NO;
        
        [self.functionMenu removeFromSuperview];
        
        if (weakSelf.close) {
            weakSelf.close(_showFunction);
        }
        return;
    }
}

//添加动画
- (void)addAnimate:(BOOL)showFunction
{
    if (showFunction == YES) {
        //scale
        CAKeyframeAnimation *scaleAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.values = @[@0.1, @1, @1.2, @1];
        scaleAnim.duration = 0.25;
        scaleAnim.repeatCount = 1;
        scaleAnim.fillMode = kCAFillModeForwards;
        scaleAnim.removedOnCompletion = NO;
        [self.imageView.layer addAnimation:scaleAnim forKey:@"btn_scale"];
    } else {
        //rotation 360°
        CABasicAnimation *rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnim.fromValue = [NSNumber numberWithFloat:0];
        rotationAnim.toValue = [NSNumber numberWithFloat:M_PI];
        rotationAnim.repeatCount = 1;
        rotationAnim.duration = 0.2;
        [self.imageView.layer addAnimation:rotationAnim forKey:@"btn_rotation"];
    }
}

//展示菜单栏
- (void)functionMenuShow
{
    [self.superview addSubview:self.functionMenu];
    self.functionMenu.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.functionMenu attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:fullButtonWidth]];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.functionMenu attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.imageNameGroup.count * (fullButtonWidth + 10)]];
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.functionMenu attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    //judge leftOrRight
    CGFloat myCenterX = self.center.x;
    if (myCenterX < KScreenWidth / 2) { //在屏幕的左侧
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.functionMenu attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:10]];
        
    } else if (myCenterX >= KScreenWidth / 2) { //屏幕的右侧
        [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.functionMenu attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    }

}

//判断悬浮球拖动结束时在屏幕的哪侧
- (void)judgeLeftOrRight:(UIPanGestureRecognizer *)pan
{
    if (!_stickToScreen) return;
    
    CGPoint endPoint = [pan locationInView:self.superview];
    if (endPoint.x < KScreenWidth / 2) {
        [UIView animateWithDuration:0.5 animations:^{
            self.lhz_x = 0;
        }];
    }
    
    if (endPoint.x > KScreenWidth / 2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.lhz_x = KScreenWidth - fullButtonWidth;
        }];
    }
}

//功能按钮点击
- (void)menuBtnClicked:(UIButton *)menuBtn {
    if ([self.delegate respondsToSelector:@selector(suspendBall:didSelectTag:)]) {
        [self.delegate suspendBall:menuBtn didSelectTag:menuBtn.tag];
    }
    NSLog(@"点击了第%ld个子悬浮球", (long)menuBtn.tag);
}

#pragma mark - Frame


#pragma mark - Lazy
- (UIView *)functionMenu
{
    if (!_functionMenu) {
        
        _functionMenu = [[UIView alloc] init];

        for (int i = 0; i < self.imageNameGroup.count; i++) {
            UIButton *functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [functionBtn setImage:[self resizeImage:[UIImage imageNamed:self.imageNameGroup[i]] wantSize:CGSizeMake(btnSmallImageWidth, btnSmallImageWidth)] forState:UIControlStateNormal];
            
            functionBtn.lhz_width = fullButtonWidth;
            functionBtn.lhz_height = fullButtonWidth;
            functionBtn.lhz_y = 0;
            functionBtn.lhz_x = i * (fullButtonWidth + 10);
            
            
            functionBtn.layer.cornerRadius = fullButtonWidth / 2;
            functionBtn.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.6];
            functionBtn.tag = i;
            [functionBtn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_functionMenu addSubview:functionBtn];
        }
    }
    return _functionMenu;
}

#pragma mark - private method
- (UIImage *)resizeImage:(UIImage *)originImage wantSize:(CGSize)wantSize
{
    UIGraphicsBeginImageContextWithOptions(wantSize, NO, 0.0);
    [originImage drawInRect:CGRectMake(0, 0, wantSize.width, wantSize.height)];
    UIImage *wantImage = UIGraphicsGetImageFromCurrentImageContext();
    return wantImage;
}

#pragma mark - other method

@end
