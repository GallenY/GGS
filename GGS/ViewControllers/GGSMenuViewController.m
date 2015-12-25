//
//  GGSMenuViewController.m
//  GGS
//
//  Created by 高阳 on 15/12/18.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSMenuViewController.h"
#import "GGSMenu.h"
#import "GGSMenuCell.h"
#import "GGSSubMenuViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <Masonry/Masonry.h>

@interface GGSMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (nonatomic, strong) NSMutableArray<GGSMenu *> *menus;

@end

@implementation GGSMenuViewController{
    NSInteger pn;
    NSString *foodName;
}

#pragma mark - Constants
//static NSString *const VIEW_TITLE = @"菜谱大全";
static NSString *const GGS_MENU_CELL = @"GGS_MENU_CELL";
static NSString *const GGS_MENU_URL = @"http://apis.haoservice.com/lifeservice/cook/query?";
static NSString *const GGS_MENU_KEY = @"32e0465853134a5281d50ada48f37d76";

#pragma mark - VC life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)setUpTableView
{
    //设置每行高度
    self.tableView.rowHeight = 120;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GGSMenuCell class]) bundle:nil] forCellReuseIdentifier:GGS_MENU_CELL];
    
    //设置tableView的header,footer，MJRefresh刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    foodName = @"肉";//设置初始搜索名
    pn = 1;
    //进入页面就开始刷新
    self.searchLabel.placeholder = foodName;
    [self showHUDWithText:@""];
    [self getDataWithReFreshType:GGSTableViewRefreshTypeNone];
}

/**
    加载网络数据
 */
- (void)loadData{
    pn = 1;
    [self getDataWithReFreshType:GGSTableViewRefreshTypeHeader];
}

/**
    加载下一页数据
 */
- (void)loadMoreData{
    pn ++;
    [self getDataWithReFreshType:GGSTableViewRefreshTypeFooter];
}

/**
 *  获取网络数据 reFreshType:刷新类型，头部还是尾部,还是search
 */
- (void)getDataWithReFreshType:(GGSTableViewRefreshType)type{
    
    [super getData];
    //设置请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"menu"] = foodName;
    param[@"key"] = GGS_MENU_KEY;
    param[@"pn"] = @(pn);
    param[@"rn"] = @10;
    //调用Manager Post方法
    [self.manager POST:GGS_MENU_URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求Menu数据成功");
        NSNumber *error_code = responseObject[@"error_code"];
        if ([error_code intValue] == 0) {
            NSArray *array = responseObject[@"result"];
            NSMutableArray *models = [GGSMenu modelArrFromJSONArr:array];
            if (type == GGSTableViewRefreshTypeHeader) {
                //结束头部刷新，给menus赋值新数据
                self.menus = models;
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            }else if (type == GGSTableViewRefreshTypeFooter) {
                //结束尾部刷新，保留原menus数据，添加新数据。
                [self.menus addObjectsFromArray:models];
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            }else {
                //搜索框，直接赋值新数据
                self.menus = models;
                [self hideHud];
                //滚到第一列
                [self.tableView reloadData];
                NSIndexPath *idx = [NSIndexPath indexPathForRow:1 inSection:0];
                [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                //结束键盘编辑
                [self.view  endEditing:YES];
            }
        }else{
            [self showHUDWithText:responseObject[@"reason"] delay:2.0];
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"连接失败 = %@",error);
        [self showHUDWithText:error.domain delay:2.0];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menus.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGSMenu *menu = self.menus[indexPath.row];
    GGSMenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:GGS_MENU_CELL];
    cell.menu = menu;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGSMenu *menu = self.menus[indexPath.row];
    NSLog(@"%@",menu.title);
    //点击进入菜谱详细信息页面
    GGSSubMenuViewController *subController = [GGSSubMenuViewController initWithMenu:menu];
    [self.navigationController pushViewController:subController animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //拖动tableView的时候结束编辑
    [self.view endEditing:YES];
}

#pragma mark - 搜索按钮点击事件
- (IBAction)searchButtonClick:(id)sender {
    foodName = self.searchLabel.text;
    //设置执行方法的时候更新
    if (IsStringEmpty(foodName)) {
        [self showHUDWithText:@"请输入要搜索的菜谱名" delay:1.0];
    }else {
        [self showHUDWithText:@"搜索中"];
        [self getDataWithReFreshType:GGSTableViewRefreshTypeNone];
    }
}


@end
