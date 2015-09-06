//
//  ComTableViewCtrl.h
//  ComTableViewCtrl
//
//  Created by wang jam on 8/30/15.
//  Copyright (c) 2015 jam wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComTableViewDelegate <NSObject>

- (void)pullUpAction:(NSDictionary*)data; //上拉响应函数
- (void)pullDownAction:(NSDictionary*)data; //下拉响应函数

@end

@interface ComTableViewCtrl : UITableViewController<ComTableViewDelegate>

- (void)allowPullUp;  //允许上拉加载
- (void)allowPullDown; //允许下拉加载

@end



