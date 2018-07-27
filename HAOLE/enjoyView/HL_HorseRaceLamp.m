//
//  HL_HorseRaceLamp.m
//  HAOLE
//
//  Created by mwl on 2018/1/4.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import "HL_HorseRaceLamp.h"

#define DEALY_WHEN_TITLE_IN_MIDDLE  5.0
#define DEALY_WHEN_TITLE_IN_BOTTOM  0.0

typedef NS_ENUM(NSUInteger, GYTitlePosition) {
    GYTitlePositionTop    = 1,
    GYTitlePositionMiddle = 2,
    GYTitlePositionBottom = 3
};

@interface HL_HorseRaceLamp ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UIView  *backView;
@property (nonatomic, strong) NSArray *contentsAry;
@property (nonatomic, assign) CGPoint topPosition;
@property (nonatomic, assign) CGPoint middlePosition;
@property (nonatomic, assign) CGPoint bottomPosition;
/*
 *1.控制延迟时间，当文字在中间时，延时时间长一些，如5秒，这样可以让用户浏览清楚内容；
 *2.当文字隐藏在底部的时候，不需要延迟，这样衔接才流畅；
 *3.通过上面的宏定义去更改需要的值
 */
@property (nonatomic, assign) CGFloat needDealy;
@property (nonatomic, assign) NSInteger currentIndex;  /*当前播放到那个标题了*/
@property (nonatomic, assign) BOOL shouldStop;         /*是否停止*/

@end

@implementation HL_HorseRaceLamp

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.topPosition   = CGPointMake(self.frame.size.width/2, -self.frame.size.height/2);
        self.middlePosition = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.bottomPosition  = CGPointMake(self.frame.size.width/2, self.frame.size.height/2*3);
        self.shouldStop = NO;
        
        _backView = [[UIView alloc]init];
        _backView.layer.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        _backView.layer.position = self.middlePosition;
        [self addSubview:_backView];
        
        UIButton* btn = [[UIButton alloc]initWithFrame:self.bounds];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = RGBHexColor(0x333333);
        _textLabel.frame = CGRectMake(0, 12, CGRectGetWidth(frame), 16);
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        [_backView addSubview:_textLabel];
        
        
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.textColor = RGBHexColor(0x999999);
        _secondLabel.frame = CGRectMake(0, 38, CGRectGetWidth(frame), 12);
        _secondLabel.font = [UIFont systemFontOfSize:12];
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        [_backView addSubview:_secondLabel];
        
        self.clipsToBounds = YES;   /*保证文字不跑出视图*/
        self.needDealy = DEALY_WHEN_TITLE_IN_MIDDLE;    /*控制第一次显示时间*/
        self.currentIndex = 0;
    }
    return self;
}

- (void)animationWithTexts:(NSArray *)textAry {
    self.contentsAry = textAry;
    self.textLabel.text = [[textAry objectAtIndex:0] objectForKey:@"title"];
    self.secondLabel.text = [[textAry objectAtIndex:0] objectForKey:@"content"];
    if (self.secondLabel.text.length < 1) {
        self.secondLabel.text = self.textLabel.text;
    }
    [self startAnimation];
}

- (void)startAnimation {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:self.needDealy options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if ([weakSelf currentTitlePosition] == GYTitlePositionMiddle) {
            weakSelf.backView.layer.position = weakSelf.topPosition;
        } else if ([weakSelf currentTitlePosition] == GYTitlePositionBottom) {
            weakSelf.backView.layer.position = weakSelf.middlePosition;
        }
    } completion:^(BOOL finished) {
        if ([weakSelf currentTitlePosition] == GYTitlePositionTop) {
            weakSelf.backView.layer.position = weakSelf.bottomPosition;
            weakSelf.needDealy = DEALY_WHEN_TITLE_IN_BOTTOM;
            weakSelf.currentIndex ++;
            weakSelf.textLabel.text = [weakSelf.contentsAry objectAtIndex:[weakSelf realCurrentIndex]][@"title"];
            weakSelf.secondLabel.text = [weakSelf.contentsAry objectAtIndex:[weakSelf realCurrentIndex]][@"content"];
            if (weakSelf.secondLabel.text.length < 1) {
                weakSelf.secondLabel.text = weakSelf.textLabel.text;
            }
        } else {
            weakSelf.needDealy = DEALY_WHEN_TITLE_IN_MIDDLE;
        }
        if (!weakSelf.shouldStop) {
            [weakSelf startAnimation];
        } else { //停止动画后，要设置label位置和label显示内容
            weakSelf.backView.layer.position = weakSelf.middlePosition;
            weakSelf.textLabel.text = [weakSelf.contentsAry objectAtIndex:[weakSelf realCurrentIndex]][@"title"];
            weakSelf.secondLabel.text = [weakSelf.contentsAry objectAtIndex:[weakSelf realCurrentIndex]][@"content"];
            if (weakSelf.secondLabel.text.length < 1) {
                weakSelf.secondLabel.text = weakSelf.textLabel.text;
            }
        }
    }];
}

- (void)stopAnimation {
    self.shouldStop = YES;
}

- (NSInteger)realCurrentIndex {
    return self.currentIndex % [self.contentsAry count];
}

- (GYTitlePosition)currentTitlePosition {
    if (self.backView.layer.position.y == self.topPosition.y) {
        return GYTitlePositionTop;
    } else if (self.backView.layer.position.y == self.middlePosition.y) {
        return GYTitlePositionMiddle;
    }
    return GYTitlePositionBottom;
}
-(void)btnAction{
    if ([self.delegate respondsToSelector:@selector(gyChangeTextView:didTapedAtIndex:)]) {
        [self.delegate gyChangeTextView:self didTapedAtIndex:[self realCurrentIndex]];
    }
}

@end
