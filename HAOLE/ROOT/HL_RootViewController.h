//
//  HL_RootViewController.h
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import <UIKit/UIKit.h>
#define navHeight 44

@interface HL_RootViewController : UIViewController
@property (nonatomic,assign)CGSize sizeTwenty;//20
@property (nonatomic,assign)CGSize sizeEight;//18
@property (nonatomic,assign)CGSize sizeSix;//16
@property (nonatomic,assign)CGSize sizeFour;//14
@property (nonatomic,assign)CGSize sizeTwo;//12
/**
 * 控制导航栏隐藏
 */
- (void)NavHidden:(BOOL)isHidden;

/**
 * 导航栏返回+标题+左右按钮
 */
-(void)initNavTitle:(NSString *)title;

-(void)initNavRightTitle:(NSString *)title;

-(void)initNavLeftTitle:(NSString *)title;

-(void)initNavTitleRightSearch:(NSString *)title;

-(void)initNavHomeSearch;

-(void)searchAction;
@end
