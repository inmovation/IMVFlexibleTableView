//
//  CustomStyleViewController.m
//  IMVFlexibleTableViewDemo
//
//  Created by Creolophus on 5/4/15.
//  Copyright (c) 2015 inmovation. All rights reserved.
//

#import "CustomStyleViewController.h"
#import "SubPullRefreshTableView.h"
#import "Page.h"

@interface CustomStyleViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) Page *page;
@property (strong, nonatomic) SubPullRefreshTableView *tableView;
@property (strong, nonatomic) NSMutableArray *localArray;

@end

@implementation CustomStyleViewController
@synthesize page = page;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"custom style";

    
    _tableView = [[SubPullRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain pullRefreshType:PRTypeTopRefreshBottomLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.tableFooterView = [UIView new];
    
    page = [Page new];

    page.pageNum = 0;
    page.pageSize = 30;
    
    __weak CustomStyleViewController *wkSelf = self;
    _tableView.refreshBlock = ^(void){
        wkSelf.page.pageNum = 0;
        [wkSelf loadData];
    };
    _tableView.loadBlock = ^(void){
        [wkSelf loadData];
    };
    [self.view addSubview:_tableView];
    
    
    
    _localArray = [NSMutableArray array];
    for (int i=0; i<page.pageSize; i++) {
        [_localArray addObject:[NSString stringWithFormat:@"%@", @(i + page.pageNum * page.pageSize)]];
    }
    page.pageNum++;
    
}

- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_tableView.isRefreshing) {
            [_localArray removeAllObjects];
        }
        
        for (int i=0; i<page.pageSize; i++) {
            [_localArray addObject:[NSString stringWithFormat:@"%@", @(i + page.pageNum * page.pageSize)]];
        }
        
        if (page.pageNum == 2) {
            _tableView.reachedEnd = YES;
        }
        page.pageNum++;
        [_tableView reloadData];
        [_tableView finishLoading];
        
    });
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _localArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _localArray[indexPath.row]];
    
    return cell;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
