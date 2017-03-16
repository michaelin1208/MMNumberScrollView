//
//  SingleNumberScrollView.h
//  scrollNumberView
//
//  Created by 9158 on 16/4/30.
//  Copyright © 2016年 9158. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSingleNumberScrollView.h"
@class MMNumberScrollViewManager;
@class MMSingleNumberScrollView;

@protocol MMSingleNumberScrollViewDelegate <NSObject>

- (void)increaseLeftSingleNumberScrollViewOf:(MMSingleNumberScrollView *)singleNumberScrollView;        // delegate method is callbacked when left number have to increase
- (void)singleNumberScrollViewFinishIncreasing:(MMSingleNumberScrollView *)singleNumberScrollView;      // delegate method is callbacked when a single number scroll view finish increasing

@end

@interface MMSingleNumberScrollView:UIView <UIScrollViewDelegate>

//@property (nonatomic,weak) MMNumberScrollViewManager *numberScrollViewManager;    //background manager, used to update beside number.
@property (nonatomic) int index;    //the index of current scroll view, used to update beside number.
@property (nonatomic,strong) NSMutableArray *numImageArray;     // import image array with all number imeges for reusing in this project.
@property (nonatomic, weak) id<MMSingleNumberScrollViewDelegate> delegate;

// show the number in the scroll view with animation or not.
-(void)showNumber:(int)number animated:(BOOL)animated;
// start the number increasing for user defined times.
-(void)increaseNumberForTimes:(int)count;
// init view with image array, speeed duration, background manager and its index (used to update the number beside it).
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray duration:(NSTimeInterval)duration index:(int)index;


@end
