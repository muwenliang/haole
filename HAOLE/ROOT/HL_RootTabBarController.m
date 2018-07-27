//
//  HL_RootTabBarController.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_RootTabBarController.h"
#import "HL_HomeViewController.h"
#import "HL_HomeMeViewController.h"
#import "HL_HomeTMQViewController.h"
#import "HL_HomeHealthViewController.h"
#import "HL_RootNavController.h"

@interface HL_RootTabBarController ()
@property (nonatomic,strong)UIView * mengView;
@property (nonatomic,strong)UIView * backView;
//@property (nonatomic,strong)HCPublishView * pushView;
@property (nonatomic,strong)UINavigationController * nav;
@property (nonatomic,strong)HL_RootNavController* navVC;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic,strong)HL_HomeHealthViewController *homeHealthVC;
@property (nonatomic,assign)int badgeValue;
@end

@implementation HL_RootTabBarController

+ (void)initialize
{
    if (GetVersion >= 9.0) {
        UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        
        NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
        dictNormal[NSForegroundColorAttributeName] = HLBlackLineColor;
        dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        
        NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
        dictSelected[NSForegroundColorAttributeName] = HLZhuOrangeColor;
        dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        
        [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
        
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HLBlackLineColor, UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:HLZhuOrangeColor, UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    //监听是否点击了第二个模块.点击了后,将所有信息改成已读,监听回调将self.badgeValue设置成0
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(easeMobUnreadZero:) name:@"easeMobUnreadZero" object:nil];
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
//    VHB_Tabar *tabbar = [[VHB_Tabar alloc] init];
//    tabbar.myDelegate = self;
//    //kvc实质是修改了系统的_tabBar
//    [self setValue:tabbar forKeyPath:@"tabBar"];
}

-(void)initView
{
    HL_HomeViewController *homeVC = [[HL_HomeViewController alloc] init];
    [self setUpOneChildVcWithVc:homeVC Image:@"home" selectedImage:@"home" title:@"首页"];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(easeMobUnread:) name:@"easeMobUnread" object:nil];
    self.homeHealthVC = [[HL_HomeHealthViewController alloc] init];
    self.badgeValue = 0;
    [self setUpOneChildVcWithVc:self.homeHealthVC Image:@"home" selectedImage:@"home" title:@"健康档案"];
    
    HL_HomeTMQViewController *HomeTMQVC = [[HL_HomeTMQViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeTMQVC Image:@"home" selectedImage:@"home" title:@"讨米圈"];
    
    
    HL_HomeMeViewController *MineVC = [[HL_HomeMeViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"home" selectedImage:@"home" title:@"我的"];
}

-(void)easeMobUnread:(NSNotification *)notification
{
    self.badgeValue = self.badgeValue + 1;
    self.homeHealthVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.badgeValue];
}

-(void)easeMobUnreadZero:(NSNotification *)notification
{
    self.badgeValue = 0;
}

- (void)setUpOneChildVcWithVc:(UIViewController *)VC Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    
    self.navVC = [[HL_RootNavController alloc] initWithRootViewController:VC];
    
    VC.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    VC.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    VC.tabBarItem.selectedImage = mySelectedImage;
    
    VC.tabBarItem.title = title;
    VC.tabBarItem.titlePositionAdjustment = UIOffsetMake(-3, -3);
    [self addChildViewController:self.navVC];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
