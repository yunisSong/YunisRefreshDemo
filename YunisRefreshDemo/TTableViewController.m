//
//  TTableViewController.m
//  YunisRefreshDemo
//
//  Created by Yunis on 15/12/29.
//  Copyright © 2015年 yunis. All rights reserved.
//

#import "TTableViewController.h"
#import "YunisHeardView.h"
#import "UIScrollView+YunisRefresh.h"
@interface TTableViewController ()
{
    YunisHeardView *t;
}
@end

@implementation TTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWindow *s = [UIApplication sharedApplication].keyWindow;

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i = 0;  i < 30; i ++) {
//            UIView *g = ({
//                UIView *view = [UIView new];
//                view.backgroundColor = [UIColor redColor];
//                view;
//            });
//            
//            g.frame = CGRectMake(0, i*10 - 1, s.frame.size.width, 1);
//            [s addSubview:g];
//        }
//    });
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    t = [YunisHeardView new];
//    [t addHeardToScrollowView:self.tableView];
    
    [self.tableView addHeaderWithCallback:^{
        NSLog(@"开始加载数据。。。。。");
    }];
    
//    [self.refreshControl beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefreshing1) name:@"PPPPPP" object:nil];

    
}
- (void)endRefreshing1
{
    [self.tableView headerEndRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
