//
//  SuspendBall.h
//  移动掌控
//
//  Created by 李昊泽 on 16/12/5.
//  Copyright © 2016年 dianbo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShowOrClose)(BOOL);
typedef void(^FunctionClickAction)(UIButton *);

@protocol SuspendBallDelegte <NSObject>

@optional
- (void)suspendBall:(UIButton *)subBall didSelectTag:(NSInteger)tag;

@end

@interface SuspendBall : UIButton

+ (instancetype)suspendBallWithFrame:(CGRect)ballFrame
                            delegate:(id<SuspendBallDelegte>)delegate
                   subBallImageArray:(NSArray *)imageArray;


/*****          数据源接口          *****/

/** 子悬浮球 图片名字 数组  */
@property (nonatomic, strong) NSArray *imageNameGroup;


/*****          悬浮球样式接口          *****/
/** 主悬浮球背景颜色  */
@property (nonatomic, strong) UIColor *superBallBackColor;
/** 主悬浮球初始状态是否需要展开  */
@property (nonatomic ,assign) BOOL showFunction;
/** 松开悬浮球后是否需要黏在屏幕的左右两端  */
@property (nonatomic ,assign) BOOL stickToScreen;

/*****          悬浮球点击事件          *****/
/** 打开 */
@property (nonatomic, copy) ShowOrClose show;
/** 关闭 */
@property (nonatomic, copy) ShowOrClose close;

/*****          控件          *****/
/** 功能菜单  */
@property (nonatomic, strong) UIView *functionMenu;
//** 代理 */
@property (nonatomic, weak) id<SuspendBallDelegte> delegate;

- (void)suspendBallShow;
@end
