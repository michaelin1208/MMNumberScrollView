## MMNumberScrollView used to show number scroll animation
In last project, I develop a number scroll view to show number increasing animations. Now I try to pick it out to share in my GitHub
 **[MMNumberScrollView](https://github.com/michaelin1208/MMNumberScrollView)**	

In this view, you can customize the number images array, the scrolling speed and the frame size of this view whether it is dynamically resizing during number increasing. 

In the next update, I might update the view to support number decreasing animation.  

```
#import <UIKit/UIKit.h>
#import "MMSingleNumberScrollView.h"

@class MMNumberScrollViewManager;

@protocol MMNumberScrollViewManagerDelegate <NSObject>

- (void)numberScrollViewManagerFinishedIncreasing:(MMNumberScrollViewManager *)manager;     // delegate method is callbacked when the number scroll view manager finish a increasing operation.

@end

@interface MMNumberScrollViewManager:UIView <UIScrollViewDelegate, MMSingleNumberScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *numImageArray;  // a mutable array of number images shown in number scroll view.
@property (nonatomic) NSTimeInterval speedDuration;  // roll speed, the duration of each increasing scrolling. The default value is 1 second.
@property (nonatomic) BOOL isShowingFinalSize;  // is it show final size at beginning. Default value is 'YES', the size of scroll view is not increasing during scrolling.

@property (nonatomic, weak) id<MMNumberScrollViewManagerDelegate> delegate;

// increase number displayed in the manager's view from currentCount to targetCount.
// You would better to start another increasing after last increasing operation finished (by "- (void)numberScrollViewManagerFinishedIncreasing:(MMNumberScrollViewManager *)manager;")
// or remove all existed number scroll views ("- (void)removeAllNumberScrollViews;").
- (void)increaseNumberFrom:(int)currentCount to:(int)targetCount;

// init the number scroll view manager to contral all single number scroll views.
- (instancetype)initWithFrame:(CGRect)frame;

// remove all single number scroll views, if you want to shwo another number increasing.
- (void)removeAllNumberScrollViews;

@end
```

## Cocoapods实践笔记
此外最近有些迷恋Cocoapods，最近都在尝试如何把自己的工程中自己工程中的三方库交给CocoaPods来管理。今天也顺道实践下怎么创建CocoaPods。方法可以参考下：
**[创建CocoaPods的制作过程](http://www.jianshu.com/p/98407f0c175b)**	
**[CocoaPods的安装使用和常见问题](http://www.jianshu.com/p/6e5c0f78200a)**

没有遇到什么特别的问题，除了个别步骤需要翻墙，推荐下[Lantern](https://github.com/getlantern/lantern)，虽然流量有上限，但是从来没超过。创建过程一切顺利，应该成功了，但是暂时在Cocoapods中还搜索不到我的工程。
