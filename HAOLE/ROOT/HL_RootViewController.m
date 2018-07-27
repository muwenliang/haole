//
//  HL_RootViewController.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_RootViewController.h"

@interface HL_RootViewController ()

@end

@implementation HL_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sizeTwenty = [HL_Tools returnSizeByString:@"卍" andFontSize:20.0f];
    self.sizeEight = [HL_Tools returnSizeByString:@"卍" andFontSize:18.0f];
    self.sizeSix = [HL_Tools returnSizeByString:@"卍" andFontSize:16.0f];
    self.sizeFour = [HL_Tools returnSizeByString:@"卍" andFontSize:14.0f];
    self.sizeTwo = [HL_Tools returnSizeByString:@"卍" andFontSize:12.0f];
    // Do any additional setup after loading the view.
}
-(void)initNavTitle:(NSString *)title
{
    self.navigationController.navigationBar.barTintColor = HL_1_NavView;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],NSForegroundColorAttributeName:HL_1_NavView}];
}
-(void)initNavRightTitle:(NSString *)title
{
    self.navigationController.navigationBar.barTintColor = HL_1_NavView;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:29],NSForegroundColorAttributeName:HL_1_NavView}];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *searchImage = [UIImage imageNamed:@"goback_imge"];
    [searchBtn setFrame:CGRectMake(ScreenWidth-31, 20, 21, 5)];
    [searchBtn setImage:searchImage forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)initNavLeftTitle:(NSString *)title
{
    self.navigationController.navigationBar.barTintColor = HL_1_NavView;
    self.navigationController.navigationBar.translucent = YES;
    NSLog(@"%@",self.navigationController.navigationBar.subviews);
    self.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:HL_6_Text}];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"goback"];
    [backBtn setFrame:CGRectMake(10, 20, 21, 22)];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
-(void)initNavTitleRightSearch:(NSString *)title
{
    self.navigationController.navigationBar.barTintColor = HL_1_NavView;
    self.navigationController.navigationBar.translucent = NO;
    self.title = title;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],NSForegroundColorAttributeName:HL_1_NavView}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"goback_imge"];
    [backBtn setFrame:CGRectMake(10, 20, 51, 22)];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *searchImage = [UIImage imageNamed:@"more_imge"];
    [searchBtn setFrame:CGRectMake(ScreenWidth-31, 20, 21, 5)];
    [searchBtn setImage:searchImage forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)initNavHomeSearch
{
    self.navigationController.navigationBar.barTintColor = HLZhuAssistOrangeColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],NSForegroundColorAttributeName:HLWriteColor_ffffff}];
    UIButton *QRBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"home"];
    [QRBtn setFrame:CGRectMake(0, 20, 21, 22)];
    [QRBtn setImage:backImage forState:UIControlStateNormal];
    [QRBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:QRBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(21, 20, 100, 20)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:titleView];
    NSLog(@"%@",self.navigationController.navigationBar);
    
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *searchImage = [UIImage imageNamed:@"home"];
    [messageBtn setFrame:CGRectMake(ScreenWidth-31, 20, 21, 5)];
    [messageBtn setImage:searchImage forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)NavHidden:(BOOL)isHidden
{
    if (isHidden == YES) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        if ([self respondsToSelector:@selector(fd_prefersNavigationBarHidden)]) {
            //            self.fd_prefersNavigationBarHidden = YES;
        }
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        if ([self respondsToSelector:@selector(fd_prefersNavigationBarHidden)]) {
            //            self.fd_prefersNavigationBarHidden = NO;
        }
    }
}

-(void)searchAction{
    //    [HCTools sharePlatformByTag:1 Dict:nil Type:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
