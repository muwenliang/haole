//
//  BoardView.m
//  umengTest
//
//  Created by 北京麦芽田网络科技有限公司 on 15/12/30.
//  Copyright © 2015年 miaozhuang. All rights reserved.
//

#import "SHBoardView.h"

@implementation SHBoardView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([self.delegate respondsToSelector:@selector(boardViewIsTouched:)]) {
        [self.delegate boardViewIsTouched:self];
    }
}

+ (instancetype)getBoardView
{
    SHBoardView *boardView = [[SHBoardView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    boardView.backgroundColor = [UIColor blackColor];
    
    boardView.alpha = 0.4;
    return boardView;
}

- (void)setBoardAlpha:(CGFloat)boardAlpha
{
    self.alpha = boardAlpha;
}

@end
