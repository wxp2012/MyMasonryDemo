//
//  ViewController.m
//  MyMasonryDemo
//
//  Created by 8107 on 15/10/22.
//  Copyright © 2015年  All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "Masonry.h"

// 获取屏幕高度
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
// 获取屏幕宽度
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width

#define NAVIGATION_COLOR  [UIColor colorWithRed:233/255.0f green:78/255.0f blue:96/255.0f alpha:1.0f]

@interface MainViewController ()
{
    UIImageView *headerImageV;
    UIView *HeaderView;
    UIView *topView;
    BOOL didRotato;
}

@property (nonatomic,strong) UITableView *mainTableV;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) NSArray *cellNameArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    didRotato = NO;
    
    //cell图片
    _imageArr = [[NSArray alloc] initWithObjects:@"Stock",@"Order",@"Delivery",@"Scanning",@"setting", nil];
    
    //cell标题
    _cellNameArr = [[NSArray alloc] initWithObjects:@"更新网上可用库存",@"订单查询",@"开始送货",@"扫描确认收货",@"店铺设定", nil];
    
    //表视图
    _mainTableV = [[UITableView alloc] init];
    _mainTableV.delegate = self;
    _mainTableV.dataSource = self;
    [_mainTableV registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"Cell"];
    _mainTableV.scrollEnabled = NO;
    _mainTableV.userInteractionEnabled = YES;
    [self.view addSubview:_mainTableV];
    
    //表视图与主视图的约束
    [_mainTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSString *imageUrlStr = _imageArr[indexPath.row];
    NSString *nameStr = _cellNameArr[indexPath.row];
    [cell setTheImage:[UIImage imageNamed:imageUrlStr] andTitle:nameStr];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kDeviceHeight - 2*(kDeviceHeight/9))/5;
}

//表头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 2*(kDeviceHeight/9))];
    HeaderView.backgroundColor = NAVIGATION_COLOR;
    
    //顶部视图
    topView = [UIView new];
    topView.backgroundColor = [UIColor clearColor];
    [HeaderView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(HeaderView);
    }];
    
    UIView *buttomView = [UIView new];
    buttomView.backgroundColor = [UIColor clearColor];
    [HeaderView addSubview:buttomView];
    [buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(HeaderView);
        make.top.equalTo(topView.mas_bottom);
        make.width.and.height.equalTo(topView);
    }];
    
    //头像及约束关系
    headerImageV = [[UIImageView alloc] init];
    headerImageV.clipsToBounds = YES;
    headerImageV.layer.cornerRadius = (HeaderView.frame.size.height/2) / 2.0f;
    headerImageV.image = [UIImage imageNamed:@"store.jpg"];
    [HeaderView addSubview:headerImageV];
    [headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(headerImageV.mas_height).multipliedBy(1);
        
        make.width.and.height.lessThanOrEqualTo(topView);
        make.width.and.height.equalTo(topView).with.priorityLow();
        
        make.centerX.equalTo(topView);
        if (didRotato == NO) {
            make.bottom.equalTo(topView.mas_bottom).offset(20);
        }
        else
        {
            make.top.equalTo(topView.mas_top);
        }
    }];
    
    //商店名称
    UILabel *shopNameL = [[UILabel alloc] init];
    shopNameL.textColor = [UIColor whiteColor];
    shopNameL.font = [UIFont systemFontOfSize:20];
    shopNameL.textAlignment = NSTextAlignmentCenter;
    shopNameL.text = @"精诚超市";
    [HeaderView addSubview:shopNameL];
    [shopNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageV.mas_bottom);
        make.left.and.right.equalTo(buttomView);
    }];
    
    //地址
    UILabel *addressL = [[UILabel alloc] init];
    addressL.font = [UIFont systemFontOfSize:10];
    addressL.textAlignment = NSTextAlignmentRight;
    addressL.textColor = [UIColor whiteColor];
    addressL.text = @"天河区万佳广场首层234号";
    [HeaderView addSubview:addressL];
    
    //gw号
    UILabel *gwNumberL = [[UILabel alloc] init];
    gwNumberL.font = addressL.font;
    gwNumberL.textColor = addressL.textColor;
    gwNumberL.textAlignment = NSTextAlignmentLeft;
    gwNumberL.text = @"  GW88888888";
    [HeaderView addSubview:gwNumberL];
    
    //地址的约束关系
    [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopNameL.mas_bottom);
        make.left.equalTo(buttomView.mas_left);
        make.right.equalTo(gwNumberL.mas_left);
        make.height.equalTo(shopNameL.mas_height);
        make.bottom.equalTo(buttomView.mas_bottom);
    }];
    
    //gw号的约束关系
    [gwNumberL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopNameL.mas_bottom);
        make.left.equalTo(addressL.mas_right);
        make.right.equalTo(buttomView.mas_right);
        make.width.equalTo(addressL.mas_width);
        make.height.equalTo(addressL.mas_height);
        make.bottom.equalTo(buttomView.mas_bottom);
    }];
    
    return HeaderView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //表头视图的高度
    return 2*(kDeviceHeight/9) ;
}

#pragma mark - 旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    didRotato = YES;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"向左,向右旋转回");
        didRotato = NO;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [_mainTableV reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
