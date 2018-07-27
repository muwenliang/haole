//
//  HL_RootNavController.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_RootNavController.h"

@interface HL_RootNavController ()

@end

@implementation HL_RootNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    return [super pushViewController:viewController animated:animated];
}

@end
