# ComTableView
* 实现通用的tableview下拉刷新，上拉刷新
* 开发者只需要定义上拉和下拉产生的数据加载事件
* 开发者需要自定义需要显示的table cell，定义cell的点击事件
* 开发者可以自定义滚动产生的事件和其他tableview事件响应
* 开发者可以启用或禁用上拉下拉刷新
## 用法
 
```objective-c
#import <UIKit/UIKit.h>
 
typedef void(^pullCompleted)();
@class ComTableViewCtrl;

@protocol ComTableViewDelegate <NSObject>

@optional
- (void)pullUpAction:(pullCompleted)completedBlock; //上拉响应函数
- (void)pullDownAction:(pullCompleted)completedBlock; //下拉响应函数
- (NSInteger)rowNum;
- (NSInteger)sectionNum;
- (UITableViewCell*)generateCell:(UITableView*)tableview indexPath:(NSIndexPath *)indexPath;
- (void)didSelectedCell:(ComTableViewCtrl*)comTableViewCtrl IndexPath:(NSIndexPath *)indexPath;
- (void)initAction:(ComTableViewCtrl*)comTableViewCtrl;
- (CGFloat)cellHeight:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath;
- (void)tableViewWillAppear:(ComTableViewCtrl*)comTableViewCtrl;
- (void)tableViewWillDisappear:(ComTableViewCtrl*)comTableViewCtrl;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
@end

@interface ComTableViewCtrl : UITableViewController

- (id)init:(BOOL)allowPullDown allowPullUp:(BOOL)allowPullUp initLoading:(BOOL)loading comDelegate:(id<ComTableViewDelegate>)delegate;

- (void)pullDown; //下拉加载

- (void)refreshNew;

- (void)forbidPullDown; //禁用下拉加载
- (void)allowPullDow; //允许下拉加载

- (void)forbidPullUp;//禁用上拉加载
- (void)allowPullUp;//允许上拉加载

@end
```

开发者实现ComTableViewDelegate接口
初始化ComTableViewCtrl时，定义是否运行下拉，上拉刷新动作，定义是否首次加载时，进行下拉刷新动作
