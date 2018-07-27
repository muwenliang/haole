//
//  BoardView.h
//  umengTest
//
//  Created by 北京麦芽田网络科技有限公司 on 15/12/30.
//  Copyright © 2015年 miaozhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHBoardView;

@protocol SHBoardViewDelegate <NSObject>

@optional
- (void)boardViewIsTouched:(SHBoardView *)boardView;

@end

@interface SHBoardView : UIView

@property (nonatomic, assign) id<SHBoardViewDelegate> delegate;

+ (instancetype)getBoardView;

@property (nonatomic, assign) CGFloat boardAlpha;

@end
