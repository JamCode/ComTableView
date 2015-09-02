# ComTableView
## ios通用tableview模块
* 实现通用的tableview下拉刷新，上拉刷新
* 开发者只需要关注上拉和下拉产生的数据加载事件
* 开发者需要自定义需要显示的table cell，定义cell的点击事件

## 用法

```
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

- (id)init:(BOOL)allowPullDown allowPullDownTitle:(NSString*)allowPullDownTitle allowPullUp:(BOOL)allowPullUp allowPullUpTitle:(NSString*)allowPullUpTitle initLoading:(BOOL)loading comDelegate:(id<ComTableViewDelegate>)delegate;

@end

```
