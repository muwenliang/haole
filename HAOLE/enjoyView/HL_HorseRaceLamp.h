//
//  HL_HorseRaceLamp.h
//  HAOLE
//
//  Created by mwl on 2018/1/4.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HL_HorseRaceLamp;

@protocol HL_HorseRaceLampDelegate <NSObject>

- (void)gyChangeTextView:(HL_HorseRaceLamp *)textView didTapedAtIndex:(NSInteger)index;

@end

@interface HL_HorseRaceLamp : UIView

@property (nonatomic, assign) id<HL_HorseRaceLampDelegate> delegate;

- (void)animationWithTexts:(NSArray *)textAry;
- (void)stopAnimation;

@end
