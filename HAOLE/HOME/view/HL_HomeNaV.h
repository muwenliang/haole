//
//  HL_HomeNaV.h
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HL_HomeNaVnavDelegate<NSObject>
-(void)navDelegateByQEAction;
-(void)navDelegateByMessageAction;
-(void)navDelegateBySearchAction;
@end
@interface HL_HomeNaV : UIView

+(instancetype)createView;

- (IBAction)QEAction:(UIButton *)sender;
- (IBAction)MessageAction:(UIButton *)sender;
- (IBAction)SearchAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (nonatomic,assign)id<HL_HomeNaVnavDelegate> delegate;

@end
