//
//  GGSMovieViewController.m
//  GGS
//
//  Created by 高阳 on 15/12/20.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSMovieViewController.h"
#import "GGSMovie.h"
#import "GGSMovieCell.h"
#import <Masonry/Masonry.h>
#import <AFHTTPSessionManager.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface GGSMovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *movies;

@end

@implementation GGSMovieViewController

#pragma mark - 全局变量
static NSString *const VIEW_TITLE = @"今日票房";
static NSString *const GGS_MOVIE_URL = @"http://apis.haoservice.com/lifeservice/boxoffice/wp";
static NSString *const GGS_MOVIE_KEY = @"0fd4eab64a9446f08f77868763b71cdc";
static NSString *const GGS_MOVIE_CELL = @"GGS_MOVIE_CELL";

#pragma mark - VC life cycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = VIEW_TITLE;
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_movie"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_item_movie_selected"];
        self.navigationItem.title = VIEW_TITLE;
    }
    return self;
}

#pragma mark - VC liftcycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTable];
    [self getData];
    
    [self showHUDWithText:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)setUpTable
{
    //创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectNull style:UITableViewStylePlain];
    UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edge);
    }];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GGSMovieCell class] )bundle:nil] forCellReuseIdentifier:GGS_MOVIE_CELL];
    tableView.rowHeight = 50;
    
    //设置头部刷新控件
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    
    //设置垂直滚动条不显示
    tableView.showsVerticalScrollIndicator = NO;
}

/**
    通过网络接口获取数据
 */
- (void)getData{
    [super getData];
    NSDictionary *param = [NSDictionary dictionaryWithObject:GGS_MOVIE_KEY forKey:@"key"];
    [self.manager POST:GGS_MOVIE_URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *error_code = responseObject[@"error_code"];
        if ([error_code intValue] == 0) {
            self.movies = [GGSMovie mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
            [self hideHud];
        }else{
            [self showHUDWithText:responseObject[@"reason"] delay:2.0];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHUDWithText:error.domain delay:2.0];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGSMovie *movie = self.movies[indexPath.row];
    movie.rank = indexPath.row;
    GGSMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:GGS_MOVIE_CELL];
    cell.movie = movie;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGSMovie *movie = self.movies[indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:movie.name message:[NSString stringWithFormat:@"上座率%@",movie.attendance] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"movieViewController.cell选中事件");
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
