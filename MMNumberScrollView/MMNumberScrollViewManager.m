//
//  NumberScrollViewManager.m
//  scrollNumberView
//
//  Created by 9158 on 16/5/9.
//  Copyright © 2016年 9158. All rights reserved.
//

//#define kNumberCount = 10

#import "MMNumberScrollViewManager.h"

@interface MMNumberScrollViewManager ()

@property (nonatomic,strong) NSMutableArray *singleNumberScrollViews;  // an array of single number scroll views

@end

@implementation MMNumberScrollViewManager {
    //    NSMutableArray *allImageViews;
    int singleNumberScrollViewWidth;
    int singleNumberScrollViewHeight;
    
    UIImageView *xImageView;
    
}

// init the number scroll view manager to contral all single number scroll views.
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isShowingFinalSize = YES;
        _speedDuration = 1;
        _singleNumberScrollViews = [[NSMutableArray alloc] init];
        singleNumberScrollViewWidth = frame.size.width;
        singleNumberScrollViewHeight = frame.size.height;
        [self initImages];
    }
    return self;
}

- (void)initImages{
    UIImage *img0  = [UIImage imageNamed:@"0img"];
    UIImage *img1  = [UIImage imageNamed:@"1img"];
    UIImage *img2  = [UIImage imageNamed:@"2img"];
    UIImage *img3  = [UIImage imageNamed:@"3img"];
    UIImage *img4  = [UIImage imageNamed:@"4img"];
    UIImage *img5  = [UIImage imageNamed:@"5img"];
    UIImage *img6  = [UIImage imageNamed:@"6img"];
    UIImage *img7  = [UIImage imageNamed:@"7img"];
    UIImage *img8  = [UIImage imageNamed:@"8img"];
    UIImage *img9  = [UIImage imageNamed:@"9img"];
    _numImageArray = [[NSMutableArray alloc] initWithObjects:img0,img1,img2,img3,img4,img5,img6,img7,img8,img9,nil];
}

// remove all single number scroll views, if you want to shwo another number increasing.
- (void)removeAllNumberScrollViews {
    for (UIView *tempView in _singleNumberScrollViews) {
        [tempView removeFromSuperview];
    }
    [_singleNumberScrollViews removeAllObjects];
}

// increase number displayed in the manager's view from currentCount to targetCount.
- (void)increaseNumberFrom:(int)currentCount to:(int)targetCount{
    int currentNumber;
    int leaveNumber = currentCount;
    int length = [self lengthOfIntValue:currentCount];
    if (_isShowingFinalSize) {
        length = [self lengthOfIntValue:targetCount];
    }
    
    // delete all view from manager view
    for (MMSingleNumberScrollView *tempView in _singleNumberScrollViews) {
        [tempView removeFromSuperview];
        [tempView.layer removeAllAnimations];
    }
    [_singleNumberScrollViews removeAllObjects];
    
    // init the single number scroll views
    MMSingleNumberScrollView *tempSingleNumberScrollView;
    for (int i = 0; i < length; i++) {
        tempSingleNumberScrollView = [[MMSingleNumberScrollView alloc]initWithFrame:CGRectMake((length - i - 1) * singleNumberScrollViewWidth, 0, singleNumberScrollViewWidth, singleNumberScrollViewHeight) imageArray:_numImageArray duration:_speedDuration index:i];
        tempSingleNumberScrollView.delegate = self;
        [self addSubview:tempSingleNumberScrollView];
        [_singleNumberScrollViews addObject:tempSingleNumberScrollView];
        
        currentNumber = leaveNumber % _numImageArray.count;
        leaveNumber = leaveNumber / _numImageArray.count;
        [tempSingleNumberScrollView showNumber:currentNumber animated:NO];
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, singleNumberScrollViewWidth * length, singleNumberScrollViewHeight)];
    [[_singleNumberScrollViews objectAtIndex:0] increaseNumberForTimes:(targetCount - currentCount)];
}

// increase the value of left single number scroll view
- (void)increaseLeftSingleNumberScrollViewOf:(MMSingleNumberScrollView *)singleNumberScrollView{
    int index = singleNumberScrollView.index;
    if (index+1 >= _singleNumberScrollViews.count) {
        [self addLeftSingleNumberScrollView];
    }
    if (index+1 < _singleNumberScrollViews.count) {
        [[_singleNumberScrollViews objectAtIndex:index+1] increaseNumberForTimes:1];
    }
}


// the increasing number action is finished
- (void)singleNumberScrollViewFinishIncreasing:(MMSingleNumberScrollView *)singleNumberScrollView{
    if (singleNumberScrollView.index == 0){
        if ([_delegate respondsToSelector:@selector(numberScrollViewManagerFinishedIncreasing:)]) {
            [_delegate numberScrollViewManagerFinishedIncreasing:self];
        }
    }
}

// it is used by right single number scroll view when it is add to 10 it has to increase the value of left scroll view.
- (void)addLeftSingleNumberScrollView{
    MMSingleNumberScrollView *tempSingleNumberScrollView;
    int newLength = (int)_singleNumberScrollViews.count + 1;
    for (int i = 0; i < newLength; i++) {
        if (i == newLength-1) {
            tempSingleNumberScrollView = [[MMSingleNumberScrollView alloc]initWithFrame:CGRectMake((newLength - i) * singleNumberScrollViewWidth, 0, singleNumberScrollViewWidth, singleNumberScrollViewHeight) imageArray:_numImageArray duration:_speedDuration index:i];
            tempSingleNumberScrollView.delegate = self;
            [self addSubview:tempSingleNumberScrollView];
            [_singleNumberScrollViews addObject:tempSingleNumberScrollView];
        }else{
            tempSingleNumberScrollView = [_singleNumberScrollViews objectAtIndex:i];
            [tempSingleNumberScrollView setFrame:CGRectMake((newLength - i) * singleNumberScrollViewWidth, 0, singleNumberScrollViewWidth, singleNumberScrollViewHeight)];
        }
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, singleNumberScrollViewWidth * newLength, singleNumberScrollViewHeight)];
}

// update all single number scroll views by a defined number
//- (void)updateSingleNumberScrollViewsByNumber:(int)number{
//    MMSingleNumberScrollView *tempSingleNumberScrollView;
//    int length = [self lengthOfIntValue:number];
//    int count = (int)_singleNumberScrollViews.count;
//    NSTimeInterval tempDuration = speedDuration;
//    for (int i = 0; i < length; i++) {
//        if (i >= count) {
//            tempSingleNumberScrollView = [[MMSingleNumberScrollView alloc]initWithFrame:CGRectMake((length - i) * singleNumberScrollViewWidth, 0, singleNumberScrollViewWidth, singleNumberScrollViewHeight) imageArray:_numImageArray duration:tempDuration index:i];
//            tempSingleNumberScrollView.delegate = self;
//            [self addSubview:tempSingleNumberScrollView];
//            [_singleNumberScrollViews addObject:tempSingleNumberScrollView];
//        }else{
//            tempSingleNumberScrollView = [_singleNumberScrollViews objectAtIndex:i];
//            [tempSingleNumberScrollView setFrame:CGRectMake((length - i) * singleNumberScrollViewWidth, 0, singleNumberScrollViewWidth, singleNumberScrollViewHeight)];
//        }
//        tempDuration = tempDuration * sqrtf(10);
//        if (tempDuration > kLongestDuration) {
//            tempDuration = kLongestDuration;
//        }
//    }
//    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, singleNumberScrollViewWidth * length, singleNumberScrollViewHeight)];
//}

// calculate the length of int value
- (int)lengthOfIntValue:(int)number{
    int length = 1;
    if (number < 0) {
        number = -number;
    }
    while (number >= _numImageArray.count) {
        number = number/_numImageArray.count;
        length++;
    }
    return length;
}

@end
