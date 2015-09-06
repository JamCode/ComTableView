//
//  ComTableViewCtrl.m
//  ComTableViewCtrl
//
//  Created by wang jam on 8/30/15.
//  Copyright (c) 2015 jam wang. All rights reserved.
//

#import "ComTableViewCtrl.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ComTableViewCtrl ()
{
    BOOL pullDown;
    BOOL pullUp;
    BOOL initLoading;
    //NSString* pullDownTitle;
    //NSString* pullUpTitle;
    id<ComTableViewDelegate> comTableDelegate;
    UIActivityIndicatorView* bottomActive;
    
}
@end

@implementation ComTableViewCtrl

static int bottomActiveHeight = 30;

@protocol ComTableViewDelegate;

- (id)init:(BOOL)allowPullDown allowPullUp:(BOOL)allowPullUp initLoading:(BOOL)loading comDelegate:(id<ComTableViewDelegate>)delegate
{
    if (self = [super init]) {
        comTableDelegate = delegate;
        pullDown = allowPullDown;
        pullUp = allowPullUp;
        initLoading = loading;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAction];
    
    if (pullDown == true) {
        [self allowPullDown];
    }
    
    if (pullUp == true) {
        [self allowPullUp];
    }
    
    if (initLoading == true) {
        [self pullDown];
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)initAction
{
    if ([comTableDelegate respondsToSelector:@selector(initAction)]) {
        [comTableDelegate initAction];
    }else{
        ;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if ([comTableDelegate respondsToSelector:@selector(rowNum)]) {
        return [comTableDelegate rowNum];
    }else{
        return 0;
    }
}

- (void)allowPullUp
{
    [self setBottomActive];
}

- (void)setBottomActive
{
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, bottomActiveHeight*2)];
    [self.tableView setTableFooterView:bottomView];
    
    bottomActive = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    bottomActive.frame = CGRectMake((ScreenWidth - bottomActiveHeight)/2, (self.tableView.tableFooterView.frame.size.height - bottomActiveHeight)/2, bottomActiveHeight, bottomActiveHeight);
    [bottomActive setColor:[UIColor grayColor]];
    [bottomActive hidesWhenStopped];
    
    for (UIView* view in self.tableView.tableFooterView.subviews) {
        [view removeFromSuperview];
    }
    [self.tableView.tableFooterView addSubview:bottomActive];
}

//- (void)setBottomTitle:(NSString*)title
//{
//    
//    if (self.tableView.contentSize.height>ScreenHeight) {
//        
////        [self.tableView.tableFooterView addSubview:[[UIView alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, )]];
//    }
//    
//    UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, bottomActiveHeight)];
//    bottomLabel.text = title;
//    bottomLabel.textAlignment = NSTextAlignmentCenter;
//    bottomLabel.textColor = [UIColor grayColor];
//    
//    for (UIView* view in self.tableView.tableFooterView.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    [self.tableView.tableFooterView addSubview:bottomLabel];
//    
//}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pullUp == YES) {
        
        CGPoint off = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        CGFloat currentOffset = off.y + bounds.size.height;
        CGFloat maximumOffset = size.height;
        
        if ([bottomActive isAnimating]) {
            return;
        }
        
        if((maximumOffset - currentOffset)<-40.0&&maximumOffset>bounds.size.height){
            
            [bottomActive startAnimating];
            [self pullUpAction];
            
        }
    }
}


- (void)pullDown
{
    if (self.refreshControl!=nil) {
        if (![self.refreshControl isRefreshing]) {
            [self.refreshControl beginRefreshing];
            [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)allowPullDown
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullDownAction) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor grayColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@""];
    
}

- (void)pullUpAction
{
    if ([comTableDelegate respondsToSelector:@selector(pullUpAction:)]) {
        [comTableDelegate pullUpAction:^{
            [self pullUpFinish];
        }];
    }else{
        
        NSLog(@"default pullUpAction");
        [self performSelector:@selector(pullUpFinish) withObject:nil afterDelay:2];
    }
}

- (void)pullDownAction
{
    if ([comTableDelegate respondsToSelector:@selector(pullDownAction:)]) {
        [comTableDelegate pullDownAction:^{
            [self pullDownFinish];
        }];
    }else{
        
        NSLog(@"default pullUpAction");
        [self performSelector:@selector(pullDownFinish) withObject:nil afterDelay:2];
    }
}

- (void)pullUpFinish
{
    [bottomActive stopAnimating];
    [self.tableView reloadData];
}

- (void)pullDownFinish
{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@""];
    [self.tableView reloadData];
    
    if (pullUp == YES) {
        [self allowPullUp];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([comTableDelegate respondsToSelector:@selector(cellHeight)]) {
        return [comTableDelegate cellHeight];
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([comTableDelegate respondsToSelector:@selector(generateCell:indexPath:)]) {
        
        return [comTableDelegate generateCell:tableView indexPath:indexPath];
    }else{
        return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([comTableDelegate respondsToSelector:@selector(didSelectedCell:IndexPath:)]) {
        return [comTableDelegate didSelectedCell:tableView IndexPath:indexPath];
    }else{
        //no select action
        ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && [self.view window] == nil) {
        NSLog(@"com table view delloc");
        
        self.view = nil;
    }
}


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
