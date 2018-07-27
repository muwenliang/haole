//
//  HL_HomeViewController.m
//  HAOLE
//
//  Created by mwl on 2017/12/22.
//  Copyright © 2017年 TJYD_. All rights reserved.
//

#import "HL_HomeViewController.h"
#import "HL_HomeNaV.h"
#import "HL_HorseRaceLamp.h"
#import "HL_DefautView.h"
#import "HL_DrawCircle.h"
#import "HL_LoginViewController.h"


@interface HL_HomeViewController ()<HL_HomeNaVnavDelegate,AVCaptureMetadataOutputObjectsDelegate,HL_HorseRaceLampDelegate>

//@property (nonatomic,strong)HL_User* user;
@property (nonatomic,strong)HL_HomeNaV * navView;
//设置默认图片
@property (nonatomic,strong)HL_DefautView * defaultView;
//跑马灯
@property (nonatomic,strong)HL_HorseRaceLamp* hrlView;
@property (nonatomic,strong)UIView* middleView;
//绘制图形
@property (nonatomic,strong)HL_DrawCircle* drawCircle;



//扫描二维码
@property (nonatomic,strong)AVCaptureDevice            * device;   //设备  手机的摄像机
@property (nonatomic,strong)AVCaptureDeviceInput       * input; //输入设备
@property (nonatomic,strong)AVCaptureMetadataOutput    * output;//输出设备
@property (nonatomic,strong)AVCaptureSession           * session; //控制器 连接输入输出设备
@property (nonatomic,strong)AVCaptureVideoPreviewLayer * preview; //视图 显示相机的范围



@end

@implementation HL_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavLeftTitle:@"登录"];
//    [self.view addSubview:self.drawCircle];
//    UIButton* netBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 50)];
//    netBtn.backgroundColor = [UIColor greenColor];
//    [netBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:netBtn];
//    [self addMiddleView];
//
//    [self.view addSubview:self.defaultView];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"请求数据" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self shareAction];
    // Do any additional setup after loading the view.
}

-(void)shareAction{
    
//    HL_LoginViewController* login = [[HL_LoginViewController alloc]init];
//    [self.navigationController pushViewController:login animated:YES];
    
    NSDictionary* dic = @{@"user":@"a",
                          @"password":@"8",
                          @"gender":@"男"
                          };
    NSString* str = @"login";
    NSLog(@"http网络连接测试程序");
    [[HL_AFNTools shareTools] POST:str parameters:dic succeed:^(id data) {
        NSLog(@"数据请求：%@",data);
    }];
}

-(void)initNavBar
{
    self.navigationController.navigationBar.barTintColor = RGBHexColor(0xff6243);
    self.navigationController.navigationBar.translucent = NO;
    self.navView = [HL_HomeNaV createView];
    self.navView.frame = CGRectMake(0, 0, ScreenWidth, navHeight);
    self.navView.delegate = self;
    [self.navigationController.navigationBar addSubview:self.navView];
}
#pragma mark 添加跑马灯
-(void)addMiddleView{
    [SVProgressHUD showWithStatus:@"开始转"];
    NSArray* arr = @[@{@"title":@"第一条消息消息消息消息消息消息消息消息",
                       @"content":@"第一条内容内容内容内容内容内容内容内容"},
                     @{@"title":@"第二条消息消息消息消息消息消息消息消息",
                       @"content":@"第二条内容内容内容内容内容内容内容内容"},
                     @{@"title":@"第3条消息消息消息消息消息消息消息消息",
                       @"content":@"第3条内容内容内容内容内容内容内容内容"},
                     @{@"title":@"第4条消息消息消息消息消息消息消息消息",
                       @"content":@"第4条内容内容内容内容内容内容内容内容"},
                     @{@"title":@"第5条消息消息消息消息消息消息消息消息",
                        @"content":@"第5条内容内容内容内容内容内容内容内容"},
                     @{@"title":@"第6条消息消息消息消息消息消息消息消息",
                       @"content":@"第6条内容内容内容内容内容内容内容内容"}];
    [self.hrlView animationWithTexts:arr];
    
}
#pragma mark -- GYChangeTextViewDelegate
- (void)gyChangeTextView:(HL_HorseRaceLamp *)textView didTapedAtIndex:(NSInteger)index
{
    NSLog(@"跑马灯第%ld被点击了",index);
}
#pragma mark HL_HomeNaVnavDelegate

-(void)navDelegateByQEAction{
    NSLog(@"二维码扫描");
    
    // Device  媒体类型很多，但实际基本只用AVMediaTypeVideo，用其它会导致程序崩溃，原因没有细究
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input  将设备作为输入设备的信息来源
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output 输出设备 需要设置代理和队列 一般使用主队列
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    // 生成控制器
    _session = [[AVCaptureSession alloc]init];
    //设置采集的质量
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    //添加输入设备
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    //添加输出设备
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // Preview 扫描视图，扫描范围
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,ScreenWidth,ScreenHeight);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    // Start 启动
    [_session startRunning];
}
-(void)navDelegateByMessageAction{
    NSLog(@"消息推送");
}
-(void)navDelegateBySearchAction{
    NSLog(@"搜索");
}



#pragma mark getter
-(HL_DrawCircle *)drawCircle{
    
    if (!_drawCircle) {
        _drawCircle = [[HL_DrawCircle alloc]initWithFrame:CGRectMake(50, 50, 300, 300)];
        
    }
    _drawCircle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_drawCircle];
    return _drawCircle;
}
-(HL_DefautView *)defaultView{
    
    if (!_defaultView) {
        _defaultView = [[HL_DefautView alloc]initWithFrame:CGRectMake(20, 300, 300, 300) currentWithImage:[UIImage imageNamed:@"home"]];
        _defaultView.backgroundColor = [UIColor greenColor];
    }
    return _defaultView;
}
-(UIView *)middleView{
    
    if (!_middleView) {
        _middleView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, ScreenWidth, 80)];
    }
    _middleView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_middleView];
    return _middleView;
}
-(HL_HorseRaceLamp *)hrlView{
    
    if (!_hrlView) {
        _hrlView = [[HL_HorseRaceLamp alloc]initWithFrame:self.middleView.bounds];
    }
    _hrlView.delegate = self;
    [self.middleView addSubview:_hrlView];
    return _hrlView;
}

@end
