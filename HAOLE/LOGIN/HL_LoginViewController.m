//
//  HL_LoginViewController.m
//  HAOLE
//
//  Created by mwl on 2018/4/26.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import "HL_LoginViewController.h"
#import "HL_User.h"
#import "HL_RegistViewController.h"
#import "HL_ForgetViewController.h"

@interface HL_LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)HL_User *user;

@property (strong, nonatomic)UIView *backHeaderView;
@property (strong, nonatomic)UIImageView* headerImgView;

@property (strong, nonatomic)UIView *phoneBackView;
@property (strong, nonatomic)UIView *phoneLineView;
@property (strong, nonatomic)UITextField *phoneTextView;
@property (strong, nonatomic)UILabel *phoneLabel;

@property (strong, nonatomic)UIView *passwordBackView;
@property (strong, nonatomic)UIView *passwordLineView;
@property (strong, nonatomic)UILabel *passwordLabel;
@property (strong, nonatomic)UITextField *passwordTextView;

@property (strong, nonatomic)UIButton *loginButton;

@property (strong, nonatomic)UIView *forgetPasswordBackView;
@property (strong, nonatomic)UIView *forgetPasswordLineView;
@property (strong, nonatomic)UIButton *forgetButton;
@property (strong, nonatomic)UIButton *registButton;

@end

@implementation HL_LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self currentViewDraw];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavLeftTitle:@"登录"];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)registerAction:(UIButton *)sender {
    NSLog(@"注册按钮");
    HL_RegistViewController* regist = [[HL_RegistViewController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}
- (void)forgetPasswordAction:(UIButton *)sender {
    NSLog(@"忘记密码");
    HL_ForgetViewController* forget = [[HL_ForgetViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}
#pragma mark action
- (void)loginAction:(UIButton *)sender {
    if (self.phoneTextView.text.length == 0) {
        [HL_Tools showErrorWithStatus:@"请输入手机号"];
    }else if ([HL_Tools isMobile:self.phoneTextView.text] == NO) {
        [HL_Tools showErrorWithStatus:@"手机格式不正确"];
    }else if (self.passwordTextView.text.length == 0) {
        [HL_Tools showErrorWithStatus:@"密码不能为空"];
    }else
    {
        //        [HCTools showSuccessWithStatus:@"登录中..."];
        [SVProgressHUD showWithStatus:@"登录中..."];
        NSString* passWord = [NSString stringWithFormat:@"%@%@",self.passwordTextView.text,MD5Str,nil];
        
        NSDictionary * dict = @{@"mobile":self.phoneTextView.text,
                                @"password":[HL_Tools md5:passWord]};
        [[HL_AFNTools shareTools]POST:LOGIN_Url parameters:dict succeed:^(id data) {
            NSLog(@"data:%@",data);
            if ([data[@"errno"] isEqual:@1]) {
                _user.userName = [NSString stringWithFormat:@"%@",data[@"data"][@"userName"],nil];
                
                //                USERDEFAULTS_SET_OBJECT(self.user_id, @"user_id");
                //                USERDEFAULTS_SET_OBJECT(data[@"data"][@"mobile"], @"mobile");
                //                USERDEFAULTS_SET_OBJECT(data[@"data"][@"avatar"], @"avatar");
                //                USERDEFAULTS_SET_OBJECT(data[@"data"][@"real_name"], @"real_name");
                //
                //                //                [HCTools showSuccessWithStatus:@"登录成功"];
                //                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                //                [SVProgressHUD dismiss];
                //                [self changeMainVC];
            }else
            {
                //                [HCTools showErrorWithStatus:data[@"message"]];
                [SVProgressHUD showErrorWithStatus:data[@"message"]];
                
            }
            
        }];
    }
}
- (void)changeText:(UITextField *)sender{
    if (self.phoneTextView.text.length > 0) {
        [self.phoneLineView setBackgroundColor:HL_2_Line];
    }else{
        [self.phoneLineView setBackgroundColor:HL_1_Line];
    }
    if (self.passwordTextView.text.length > 0) {
        [self.passwordLineView setBackgroundColor:HL_2_Line];
    }else{
        [self.passwordLineView setBackgroundColor:HL_1_Line];
    }
    if (self.passwordTextView.text.length > 0 && self.phoneTextView.text.length > 0) {
        [self.loginButton setBackgroundColor:HL_2_Button];
        [self.loginButton setTitleColor:RGBHexColor(0xFFFFFF) forState:UIControlStateNormal];
    }else{
        [self.loginButton setBackgroundColor:HL_1_Button];
        [self.loginButton setTitleColor:HLZhuOrangeColor forState:UIControlStateNormal];
    }
    
}

#pragma mark --UITextViewDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [textField isFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSLog(@"");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return [textField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    NSLog(@"");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return [textField resignFirstResponder];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 初始化当前界面样式
-(void)currentViewDraw{
    self.backHeaderView.backgroundColor = HL_1_alpha;
    self.backHeaderView.sd_layout
    .centerXIs(ScreenWidth/2)
    .yIs(kBiLiHeight(114))
    .widthIs(kBiLiWidth(106))
    .heightIs(kBiLiHeight(106));
    self.headerImgView.sd_layout
    .centerXIs(self.backHeaderView.width/2)
    .centerYIs(self.backHeaderView.height/2)
    .widthIs(kBiLiWidth(95))
    .heightIs(kBiLiHeight(95));
    
    self.phoneBackView.sd_layout
    .topSpaceToView(self.backHeaderView, kBiLiHeight(47))
    .leftSpaceToView(self.view, 38)
    .rightSpaceToView(self.view, 38)
    .heightIs(kBiLiHeight(23));
    self.phoneLabel.sd_layout
    .topSpaceToView(self.phoneBackView, 0)
    .leftSpaceToView(self.phoneBackView, 0)
    .widthIs(50)
    .heightIs(15);
    self.phoneTextView.sd_layout
    .topSpaceToView(self.phoneBackView, 0)
    .leftSpaceToView(self.phoneLabel, 0)
    .rightSpaceToView(self.phoneBackView, 0)
    .heightIs(15);
    self.phoneLineView.sd_layout
    .bottomSpaceToView(self.phoneBackView, 0)
    .leftSpaceToView(self.phoneBackView, 0)
    .rightSpaceToView(self.phoneBackView, 0)
    .heightIs(1);
    
    self.passwordBackView.sd_layout
    .topSpaceToView(self.phoneBackView, kBiLiHeight(30))
    .leftSpaceToView(self.view, 38)
    .rightSpaceToView(self.view, 38)
    .heightIs(kBiLiHeight(23));
    self.passwordLabel.sd_layout
    .topSpaceToView(self.passwordBackView, 0)
    .leftSpaceToView(self.passwordBackView, 0)
    .widthIs(50)
    .heightIs(15);
    self.passwordTextView.sd_layout
    .topSpaceToView(self.passwordBackView, 0)
    .leftSpaceToView(self.passwordLabel, 0)
    .rightSpaceToView(self.passwordBackView, 0)
    .heightIs(15);
    self.passwordLineView.sd_layout
    .bottomSpaceToView(self.passwordBackView, 0)
    .leftSpaceToView(self.passwordBackView, 0)
    .rightSpaceToView(self.passwordBackView, 0)
    .heightIs(1);
    
    
    self.loginButton.sd_layout
    .topSpaceToView(self.passwordBackView, kBiLiHeight(30))
    .leftSpaceToView(self.view, kBiLiWidth(41))
    .rightSpaceToView(self.view, kBiLiWidth(41))
    .heightIs(kBiLiHeight(44));
    
    self.forgetPasswordBackView.sd_layout
    .topSpaceToView(self.loginButton, kBiLiHeight(30))
    .leftSpaceToView(self.view, 41)
    .rightSpaceToView(self.view, 41)
    .heightIs(kBiLiHeight(13));
    self.forgetButton.sd_layout
    .topSpaceToView(self.forgetPasswordBackView, 0)
    .leftSpaceToView(self.forgetPasswordBackView, 0)
    .widthIs((ScreenWidth-84)/2)
    .bottomSpaceToView(self.forgetPasswordBackView, 0);
    self.forgetPasswordLineView.sd_layout
    .topSpaceToView(self.forgetPasswordBackView, 0)
    .leftSpaceToView(self.forgetButton, 0)
    .widthIs(1)
    .bottomSpaceToView(self.forgetPasswordBackView, 0);
    
    self.registButton.sd_layout
    .topSpaceToView(self.forgetPasswordBackView, 0)
    .leftSpaceToView(self.forgetPasswordLineView, 0)
    .rightSpaceToView(self.forgetPasswordBackView, 0)
    .bottomSpaceToView(self.forgetPasswordBackView, 0);
}

#pragma mark 懒加载
-(UIView *)backHeaderView{
    if (!_backHeaderView) {
        _backHeaderView = [[UIView alloc]init];
    }
    _backHeaderView.layer.cornerRadius = 53;
    [self.view addSubview:_backHeaderView];
    return _backHeaderView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]init];
    }
    [self.backHeaderView addSubview:_headerImgView];
    _headerImgView.image = [UIImage imageNamed:@"login_user"];
    return _headerImgView;
}
-(UIView *)phoneBackView{
    if (!_phoneBackView) {
        _phoneBackView = [[UIView alloc]init];
    }
    
    [self.view addSubview:_phoneBackView];
    return _phoneBackView;
}
-(UIView *)phoneLineView{
    if (!_phoneLineView) {
        _phoneLineView = [[UIView alloc]init];
    }
    _phoneLineView.backgroundColor = HL_1_Line;
    [self.phoneBackView addSubview:_phoneLineView];
    return _phoneLineView;
}
-(UITextField *)phoneTextView{
    if (!_phoneTextView) {
        _phoneTextView = [[UITextField alloc]init];
    }
    [_phoneTextView setFont:[UIFont systemFontOfSize:15]];
    [_phoneTextView setTextColor:[UIColor blackColor]];
    _phoneTextView.delegate = self;
    [_phoneTextView setPlaceholder:@"手机号"];
    [_phoneTextView addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventValueChanged];
    [self.phoneBackView addSubview:_phoneTextView];
    return _phoneTextView;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
    }
    _phoneLabel.text = @"账号";
    _phoneLabel.textColor = [UIColor blackColor];
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    [self.phoneBackView addSubview:_phoneLabel];
    return _phoneLabel;
}
-(UIView *)passwordBackView{
    if (!_passwordBackView) {
        _passwordBackView = [[UIView alloc]init];
    }
    [self.view addSubview:_passwordBackView];
    return _passwordBackView;
}
-(UIView *)passwordLineView{
    if (!_passwordLineView) {
        _passwordLineView = [[UIView alloc]init];
    }
    _passwordLineView.backgroundColor = HL_1_Line;
    [self.passwordBackView addSubview:_passwordLineView];
    return _passwordLineView;
}
-(UITextField *)passwordTextView{
    if (!_passwordTextView) {
        _passwordTextView = [[UITextField alloc]init];
    }
    [_passwordTextView setFont:[UIFont systemFontOfSize:15]];
    [_passwordTextView setTextColor:[UIColor blackColor]];
    [_passwordTextView setPlaceholder:@"请输入密码"];
    [_passwordTextView addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventValueChanged];
    _passwordTextView.delegate = self;
    [self.passwordBackView addSubview:_passwordTextView];
    return _passwordTextView;
}
-(UILabel *)passwordLabel{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc]init];
    }
    _passwordLabel.text = @"密码";
    _passwordLabel.textColor = [UIColor blackColor];
    _passwordLabel.font = [UIFont systemFontOfSize:15];
    [self.passwordBackView addSubview:_passwordLabel];
    return _passwordLabel;
}

-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc]init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:HL_2_Button forState:UIControlStateNormal];
    }
    
    _loginButton.backgroundColor =  HL_1_Button;
    _loginButton.layer.cornerRadius = 4;
    _loginButton.layer.borderWidth = 1;
    _loginButton.layer.borderColor = HL_3_ButtonBorder.CGColor;
    [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    return _loginButton;
}
-(UIView *)forgetPasswordBackView{
    if (!_forgetPasswordBackView) {
        _forgetPasswordBackView = [[UIView alloc]init];
    }
    [self.view addSubview:_forgetPasswordBackView];
    return _forgetPasswordBackView;
}
-(UIView *)forgetPasswordLineView{
    if (!_forgetPasswordLineView) {
        _forgetPasswordLineView = [[UIView alloc]init];
    }
    _forgetPasswordLineView.backgroundColor = HL_4_Line;
    [self.forgetPasswordBackView addSubview:_forgetPasswordLineView];
    return _forgetPasswordLineView;
}
-(UIButton *)forgetButton{
    if (!_forgetButton) {
        _forgetButton = [[UIButton alloc]init];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:HL_2_Line forState:UIControlStateNormal];
    }
    [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetButton setTitleColor:HL_2_Line forState:UIControlStateNormal];
    [_forgetButton addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPasswordBackView addSubview:_forgetButton];
    return _forgetButton;
}
-(UIButton *)registButton{
    if (!_registButton) {
        _registButton = [[UIButton alloc]init];
        [_registButton setTitle:@"快速注册" forState:UIControlStateNormal];
        [_registButton setTitleColor:HL_2_Line forState:UIControlStateNormal];
    }
    [_registButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPasswordBackView addSubview:_registButton];
    return _registButton;
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
