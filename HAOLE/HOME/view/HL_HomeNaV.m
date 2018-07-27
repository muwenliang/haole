//
//  HL_HomeNaV.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_HomeNaV.h"

@implementation HL_HomeNaV

+(instancetype)createView
{
    NSString *className = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil] firstObject];
}

- (IBAction)QEAction:(UIButton *)sender {
    [self.delegate navDelegateByQEAction];
}
- (IBAction)MessageAction:(UIButton *)sender {
    [self.delegate navDelegateByMessageAction];
}

- (IBAction)SearchAction:(UIButton *)sender {
    [self.delegate navDelegateBySearchAction];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.searchView.layer.cornerRadius = 15.0f;
    self.searchView.layer.borderWidth = 1.0f;
    self.searchView.layer.borderColor = HLGrayLineColor.CGColor;
    
}

@end
