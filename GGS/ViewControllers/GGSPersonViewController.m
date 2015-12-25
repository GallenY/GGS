//
//  GGSPersonViewController.m
//  GGS
//
//  Created by 高阳 on 15/12/20.
//  Copyright © 2015年 高阳. All rights reserved.
//

#import "GGSPersonViewController.h"
#import "GGSPersonGroupItem.h"

@interface GGSPersonViewController () <UITableViewDataSource, UIBarPositioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<GGSPersonGroupItem *> *groupItems;

@end

@implementation GGSPersonViewController

- (NSMutableArray<GGSPersonGroupItem *> *)groupItems
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _groupItems = [NSMutableArray array];
    });
    return _groupItems;
}

#pragma mark - Constants
static NSString *const VIEW_TITLE = @"个人";
static NSString *const GGS_PERSON_CELL_ONE = @"GGS_PERSON_CELL_ONE";
static NSString *const GGS_PERSON_CELL_TWO = @"GGS_PERSON_CELL_TWO";

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.tabBarItem.title = VIEW_TITLE;
//        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_item_person"];
//        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_item_person_selected"];
//        self.navigationItem.title = VIEW_TITLE;
//    }
//    return self;
//}

#pragma mark - VC life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    //添加2组数据
    GGSPersonGroupItem *groupOne = [[GGSPersonGroupItem alloc] init];
    ;
    groupOne.items = [NSArray arrayWithObjects:[GGSPersonItem itemWithTitle:@"本地菜谱(施工中)" cellId:GGS_PERSON_CELL_ONE], [GGSPersonItem itemWithTitle:@"清除缓存(施工中)" cellId:GGS_PERSON_CELL_ONE],nil];
    GGSPersonGroupItem *groupTwo = [[GGSPersonGroupItem alloc] init];
    groupTwo.items = [NSArray arrayWithObjects:[GGSPersonItem itemWithTitle:@"关于我(点击有惊喜)" cellId:GGS_PERSON_CELL_TWO],nil];;
    [self.groupItems addObject:groupOne];
    [self.groupItems addObject:groupTwo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupItems.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GGSPersonGroupItem *groupItem = self.groupItems[section];
    return groupItem.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GGSPersonGroupItem *groupItem = self.groupItems[indexPath.section];
    GGSPersonItem *item = groupItem.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellId];
    cell.textLabel.text = item.title;
    return cell;
}


@end
