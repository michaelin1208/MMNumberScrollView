//
//  NumberScrollViewManager.h
//  scrollNumberView
//
//  Created by 9158 on 16/5/9.
//  Copyright © 2016年 9158. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSingleNumberScrollView.h"

@class MMNumberScrollViewManager;

@protocol MMNumberScrollViewManagerDelegate <NSObject>

- (void)numberScrollViewManagerFinishedIncreasing:(MMNumberScrollViewManager *)manager;     // delegate method is callbacked when the number scroll view manager finish a increasing operation.

@end

@interface MMNumberScrollViewManager:UIView <UIScrollViewDelegate, MMSingleNumberScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *numImageArray;                      // a mutable array of number images shown in number scroll view.
@property (nonatomic) NSTimeInterval speedDuration;                              // roll speed, the duration of each increasing scrolling. The default value is 1 second.
@property (nonatomic) BOOL isShowingFinalSize;                                   // is it show final size at beginning. Default value is 'YES', the size of scroll view is not increasing during scrolling.

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
