//
//  ComTableViewCtrl.h
//  ComTableViewCtrl
//
//  Created by wang jam on 8/30/15.
//  Copyright (c) 2015 jam wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pullCompleted)();

@protocol ComTableViewDelegate <NSObject>

@required
- (void)pullUpAction:(pullCompleted)completedBlock; //上拉响应函数
- (void)pullDownAction:(pullCompleted)completedBlock; //下拉响应函数
- (NSInteger)rowNum;
- (UITableViewCell*)generateCell:(UITableView*)tableview indexPath:(NSIndexPath *)indexPath;
- (void)didSelectedCell:(UITableView*)tableView IndexPath:(NSIndexPath *)indexPath;
- (void)initAction;
- (CGFloat)cellHeight;
@end

@interface ComTableViewCtrl : UITableViewController

- (id)init:(BOOL)allowPullDown allowPullUp:(BOOL)allowPullUp initLoading:(BOOL)loading comDelegate:(id<ComTableViewDelegate>)delegate;

@end



