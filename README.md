# ComTableView
* 实现通用的tableview下拉刷新，上拉刷新
* 开发者只需要关注上拉和下拉产生的数据加载事件
* 开发者需要自定义需要显示的table cell，定义cell的点击事件

## 用法

```objective-c
#import <UIKit/UIKit.h>

typedef void(^pullCompleted)();

@protocol ComTableViewDelegate <NSObject>

@required
- (void)pullUpAction:(pullCompleted)completedBlock; //上拉响应函数
- (void)pullDownAction:(pullCompleted)completedBlock; //下拉响应函数
- (NSInteger)rowNum;
- (UITableViewCell*)generateCell:(UITableView*)tableview indexPath:(NSIndexPath *)indexPath;
@end

@interface ComTableViewCtrl : UITableViewController

- (id)init:(BOOL)allowPullDown allowPullUp:(BOOL)allowPullUp initLoading:(BOOL)loading comDelegate:(id<ComTableViewDelegate>)delegate;

@end

```

开发者实现ComTableViewDelegate接口
初始化ComTableViewCtrl时，定义是否运行下拉，上拉刷新动作，定义是否首次加载时，进行下拉刷新动作
