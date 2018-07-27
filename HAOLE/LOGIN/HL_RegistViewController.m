//
//  HL_RegistViewController.m
//  HAOLE
//
//  Created by mwl on 2018/5/8.
//  Copyright © 2018年 TJYD_. All rights reserved.
//

#import "HL_RegistViewController.h"

@interface HL_RegistViewController ()<UITextFieldDelegate>
@property (strong, nonatomic)UIView *phoneBackView;
@property (strong, nonatomic)UIView *phoneLineView;
@property (strong, nonatomic)UITextField *phoneTextView;
@property (strong, nonatomic)UILabel *phoneLabel;


@property (strong, nonatomic)UIView *codeBackView;
@property (strong, nonatomic)UIView *codeLineView;
@property (strong, nonatomic)UITextField *codeTextView;
@property (strong, nonatomic)UILabel *codeLabel;
@property (strong, nonatomic)UIButton *codeButton;


@property (strong, nonatomic)UIView *passwordBackView;
@property (strong, nonatomic)UIView *passwordLineView;
@property (strong, nonatomic)UILabel *passwordLabel;
@property (strong, nonatomic)UITextField *passwordTextView;

@property (strong, nonatomic)UIButton *registButton;

@property (strong, nonatomic)UIButton *loginBtn;

@property (strong, nonatomic)UIButton *protocolBtn;

@end

@implementation HL_RegistViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavLeftTitle:@"快速注册"];
    
    [self currentViewDraw];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark action
-(void)registAction:(UIButton*)sender{
    NSLog(@"注册按钮");
}
-(void)loginAction:(UIButton*)sender{
    NSLog(@"登录按钮");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)protocolAction:(UIButton*)sender{
    NSLog(@"用户协议按钮");
}
-(void)codeAction:(UIButton*)sender{
    NSLog(@"发送验证码");
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
        [self.registButton setBackgroundColor:HL_2_Button];
        [self.registButton setTitleColor:RGBHexColor(0xFFFFFF) forState:UIControlStateNormal];
    }else{
        [self.registButton setBackgroundColor:HL_1_Button];
        [self.registButton setTitleColor:HLZhuOrangeColor forState:UIControlStateNormal];
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

    self.phoneBackView.sd_layout
    .topSpaceToView(self.view, kBiLiHeight(128))
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
    
    
    self.codeBackView.sd_layout
    .topSpaceToView(self.phoneBackView, kBiLiHeight(30))
    .leftSpaceToView(self.view, 38)
    .rightSpaceToView(self.view, 38)
    .heightIs(kBiLiHeight(23));
    self.codeLabel.sd_layout
    .topSpaceToView(self.codeBackView, 0)
    .leftSpaceToView(self.codeBackView, 0)
    .widthIs(50)
    .heightIs(15);
    self.codeTextView.sd_layout
    .topSpaceToView(self.codeBackView, 0)
    .leftSpaceToView(self.codeLabel, 0)
    .rightSpaceToView(self.codeBackView, 90)
    .heightIs(15);
    self.codeButton.sd_layout
    .topSpaceToView(self.codeBackView, 0)
    .leftSpaceToView(self.codeTextView, 0)
    .rightSpaceToView(self.codeBackView, 0)
    .heightIs(15);
    self.codeLineView.sd_layout
    .bottomSpaceToView(self.codeBackView, 0)
    .leftSpaceToView(self.codeBackView, 0)
    .rightSpaceToView(self.codeBackView, 0)
    .heightIs(1);
    
    
    self.passwordBackView.sd_layout
    .topSpaceToView(self.codeBackView, kBiLiHeight(30))
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


    self.registButton.sd_layout
    .topSpaceToView(self.passwordBackView, kBiLiHeight(30))
    .leftSpaceToView(self.view, kBiLiWidth(41))
    .rightSpaceToView(self.view, kBiLiWidth(41))
    .heightIs(kBiLiHeight(44));
    
    
    self.loginBtn.sd_layout
    .topSpaceToView(self.registButton, kBiLiHeight(25))
    .leftSpaceToView(self.view, kBiLiWidth(41))
    .rightSpaceToView(self.view, kBiLiWidth(41))
    .heightIs(kBiLiHeight(13));
    
    self.protocolBtn.sd_layout
    .topSpaceToView(self.loginBtn, kBiLiHeight(46))
    .leftSpaceToView(self.view, kBiLiWidth(41))
    .rightSpaceToView(self.view, kBiLiWidth(41))
    .heightIs(kBiLiHeight(16));
}
#pragma mark 懒加载
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
    _phoneLabel.text = @"账    号";
    _phoneLabel.textColor = [UIColor blackColor];
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    [self.phoneBackView addSubview:_phoneLabel];
    return _phoneLabel;
}
-(UIView *)codeBackView{
    if (!_codeBackView) {
        _codeBackView = [[UIView alloc]init];
    }
    
    [self.view addSubview:_codeBackView];
    return _codeBackView;
}
-(UIView *)codeLineView{
    if (!_codeLineView) {
        _codeLineView = [[UIView alloc]init];
    }
    _codeLineView.backgroundColor = HL_1_Line;
    [self.codeBackView addSubview:_codeLineView];
    return _codeLineView;
}
-(UITextField *)codeTextView{
    if (!_codeTextView) {
        _codeTextView = [[UITextField alloc]init];
    }
    [_codeTextView setFont:[UIFont systemFontOfSize:15]];
    [_codeTextView setTextColor:[UIColor blackColor]];
    [_codeTextView setPlaceholder:@"请输入验证码"];
    [_codeTextView addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventValueChanged];
    _codeTextView.delegate = self;
    [self.codeBackView addSubview:_codeTextView];
    return _codeTextView;
}
-(UILabel *)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
    }
    _codeLabel.text = @"验证码";
    _codeLabel.textColor = [UIColor blackColor];
    _codeLabel.font = [UIFont systemFontOfSize:15];
    [self.codeBackView addSubview:_codeLabel];
    return _codeLabel;
}
-(UIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [[UIButton alloc]init];
        [_codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeButton setTitleColor:HL_2_Button forState:UIControlStateNormal];
    }
    _codeButton.titleLabel.font = sizeSystemFont(14);
    [_codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeBackView addSubview:_codeButton];
    return _codeButton;
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
    _passwordLabel.text = @"密    码";
    _passwordLabel.textColor = [UIColor blackColor];
    _passwordLabel.font = [UIFont systemFontOfSize:15];
    [self.passwordBackView addSubview:_passwordLabel];
    return _passwordLabel;
}

-(UIButton *)registButton{
    if (!_registButton) {
        _registButton = [[UIButton alloc]init];
        [_registButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registButton setTitleColor:HL_2_Button forState:UIControlStateNormal];
    }
    
    _registButton.backgroundColor =  HL_1_Button;
    _registButton.layer.cornerRadius = 4;
    _registButton.layer.borderWidth = 1;
    _registButton.layer.borderColor = HL_3_ButtonBorder.CGColor;
    [_registButton addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registButton];
    return _registButton;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitleColor:HL_2_Button forState:UIControlStateNormal];
    }
    [_loginBtn setAttributedTitle:[HL_Tools CenterRTFAllStr:@"已有账户？直接登录" TargetArr:@[@"直接登录"] DefaultColor:HL_1_Text targetColor:HL_2_Button DefaulrFont:sizeSystemFont(13) LineSpacing:0] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    return _loginBtn;
}
-(UIButton *)protocolBtn{
    if (!_protocolBtn) {
        _protocolBtn = [[UIButton alloc]init];
        [_protocolBtn setTitleColor:HL_2_Button forState:UIControlStateNormal];
    }
    [_protocolBtn setAttributedTitle:[HL_Tools CenterRTFAllStr:@"阅读并同意好了用户服务协议" TargetArr:@[@"好了用户服务协议"] DefaultColor:HL_1_Text targetColor:HL_2_Button DefaulrFont:sizeSystemFont(13) LineSpacing:0] forState:UIControlStateNormal];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"agree_icon"]];
    [_protocolBtn setImage:[UIImage imageNamed:@"agree_icon"] forState:UIControlStateNormal];
//    [_protocolBtn ];
    [_protocolBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_protocolBtn];
    return _protocolBtn;
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
