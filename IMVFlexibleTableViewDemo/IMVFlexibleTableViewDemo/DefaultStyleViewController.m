//
//  ViewController.m
//  IMVFlexibleTableViewDemo
//
//  Created by Creolophus on 5/4/15.
//  Copyright (c) 2015 inmovation. All rights reserved.
//

#import "DefaultStyleViewController.h"
#import "IMVFlexibleTableView.h"
#import "Page.h"

@interface DefaultStyleViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IMVFlexibleTableView *tableView;

@property (strong, nonatomic) NSMutableArray *localArray;

@property (strong, nonatomic) Page *page;

@end




@implementation DefaultStyleViewController
@synthesize page = page;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"default style";
    
    _tableView = [[IMVFlexibleTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain pullRefreshType:PRTypeTopRefreshBottomLoad];
//    _tableView.topRefreshView.tintColor = [UIColor grayColor];
//    _tableView.loadMoreView.tintColor = [UIColor grayColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.tableFooterView = [UIView new];
    
    page = [Page new];
    page.pageNum = 0;
    page.pageSize = 20;
    
    __weak DefaultStyleViewController *wkSelf = self;
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
    [_localArray removeAllObjects];
    page.pageNum++;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"%@", NSStringFromUIEdgeInsets(_tableView.contentInset));
    NSLog(@"%@", NSStringFromCGRect(_tableView.frame));

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"%@", NSStringFromCGRect(_tableView.loadMoreView.frame));

}

- (void)loadData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_tableView.isRefreshing) {
            [_localArray removeAllObjects];
        }
        
        for (int i=0; i<page.pageSize; i++) {
            [_localArray addObject:[NSString stringWithFormat:@"%@", @(i + page.pageNum * page.pageSize)]];
        }
        
        if (page.pageNum == 1) {
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
