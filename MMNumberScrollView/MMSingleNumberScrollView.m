//
//  SingleNumberScrollView.m
//  scrollNumberView
//
//  Created by 9158 on 16/4/30.
//  Copyright © 2016年 9158. All rights reserved.
//

//#define kNumberCount 10
//#define kDuration 0.2
//xcode github test

#import "MMSingleNumberScrollView.h"

@interface MMSingleNumberScrollView ()


@end

@implementation MMSingleNumberScrollView {
//    NSMutableArray *allImageViews;
    
    UIScrollView    *numberScrollView;  //scroll view to show numbers and scroll.
    
    // three image views to reuse in scroll view.
    UIImageView     *currentImageView;
    UIImageView     *nextImageView;
    UIImageView     *previousImageView;
    
    int currentPage;                    //the current page index of indext, it is as same as the number displayed.
    int increaseCount;                  //the count to record how many times the number have to increase.
    NSTimeInterval speedDuration;       //roll speed, the duration of each increasing scrolling  

}

// init view with image array, speed duration, background manager and its index (used to update the number beside it).
- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray duration:(NSTimeInterval)duration index:(int)index{
    self = [super initWithFrame:frame];
    if (self) {
        numberScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:numberScrollView];
        
        speedDuration = duration;
        _numImageArray = imageArray;
        _index = index;
        
        // init three image views
        currentPage = 0;
        currentImageView = [[UIImageView alloc] initWithImage:[_numImageArray objectAtIndex: 0]];
        currentImageView.frame = CGRectMake(0, 1*frame.size.height, frame.size.width, frame.size.height);
        [currentImageView setContentMode:UIViewContentModeScaleAspectFit];
        [numberScrollView addSubview:currentImageView];
        
        nextImageView = [[UIImageView alloc] initWithImage:[_numImageArray objectAtIndex: 1]];
        nextImageView.frame = CGRectMake(0, 2*frame.size.height, frame.size.width, frame.size.height);
        [nextImageView setContentMode:UIViewContentModeScaleAspectFit];
        [numberScrollView addSubview:nextImageView];
        
        previousImageView = [[UIImageView alloc] initWithImage:[_numImageArray objectAtIndex: 9]];
        previousImageView.frame = CGRectMake(0, 0*frame.size.height, frame.size.width, frame.size.height);
        [previousImageView setContentMode:UIViewContentModeScaleAspectFit];
        [numberScrollView addSubview:previousImageView];
        
        // set the scroll view
        numberScrollView.showsVerticalScrollIndicator = NO;
        numberScrollView.showsHorizontalScrollIndicator = NO;
        numberScrollView.pagingEnabled = YES;
        numberScrollView.bounces = NO;
        numberScrollView.userInteractionEnabled = YES;
        numberScrollView.scrollEnabled = YES;
        numberScrollView.contentSize = CGSizeMake(self.bounds.size.width, 3*self.bounds.size.height);
        [numberScrollView setContentOffset:CGPointMake(0, self.bounds.size.height)];
        [numberScrollView setDelegate: self];
    }
    return self;
}

// update the scorll view after each scrolling animation, in order to move the current number into the middle image view.
- (void)updateScrollView:(int)offset{
    // the update actions for scroll up animations, which is not useful for my project.
    if (offset == 0) {
        currentImageView.image = previousImageView.image;
        numberScrollView.contentOffset = CGPointMake(0, numberScrollView.bounds.size.height);
        previousImageView.image = nil;
        if (currentPage == 0) {
            currentPage = 9;
        }else{
            currentPage -= 1;
        }
        // check the previous and next image views, and guarantee the images there is correct.
        if (nextImageView.image == nil || previousImageView.image == nil) {
            nextImageView.image = [_numImageArray objectAtIndex: currentPage == 9 ? 0 : currentPage + 1];
            previousImageView.image = [_numImageArray objectAtIndex: currentPage == 0 ? 9 : currentPage - 1];
        }
    }
    // the update actions for scroll down animations, which is important to check whether it have to keep increasing the number.
    if (offset == numberScrollView.bounds.size.height * 2) {
        currentImageView.image = nextImageView.image;
        numberScrollView.contentOffset = CGPointMake(0, numberScrollView.bounds.size.height);
        nextImageView.image = nil;
        if (currentPage == 9) {
            currentPage = 0;
        }else{
            currentPage += 1;
        }
        // check the previous and next image views, and guarantee the images there is correct.
        if (nextImageView.image == nil || previousImageView.image == nil) {
            nextImageView.image = [_numImageArray objectAtIndex: currentPage == 9 ? 0 : currentPage + 1];
            previousImageView.image = [_numImageArray objectAtIndex: currentPage == 0 ? 9 : currentPage - 1];
        }
        // check whether it have to keep increasing the number.
        if (increaseCount>0) {
            if (currentPage == 9) {
                if ([_delegate respondsToSelector:@selector(increaseLeftSingleNumberScrollViewOf:)]) {
                    [_delegate increaseLeftSingleNumberScrollViewOf:self];
                }
            }
            increaseCount --;
            [self moveUpAnimation];
        }else{
            if ([_delegate respondsToSelector:@selector(singleNumberScrollViewFinishIncreasing:)]) {
                [_delegate singleNumberScrollViewFinishIncreasing:self];
            }
        }
    }
}

// the move up animation, in order to set customized scrolling speed.
- (void)moveUpAnimation{
    if (self.superview) {
        [UIView animateWithDuration:speedDuration animations:^{
            numberScrollView.contentOffset = CGPointMake(0, 2 * numberScrollView.bounds.size.height);
        } completion:^(BOOL finished) {
            [self updateScrollView:2 * numberScrollView.bounds.size.height];
        }];
    }
}

// the move up animation, in order to set customized scrolling speed.
- (void)moveDownAnimation{
    if (self.superview) {
        [UIView animateWithDuration:speedDuration animations:^{
            numberScrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self updateScrollView:0];
        }];
    }
}

// start the number increasing for user defined times.
-(void)increaseNumberForTimes:(int)count{
    increaseCount = count;
    if (increaseCount>0) {
        if (currentPage == 9) {
            if ([_delegate respondsToSelector:@selector(increaseLeftSingleNumberScrollViewOf:)]) {
                [_delegate increaseLeftSingleNumberScrollViewOf:self];
            }
        }
        increaseCount --;
        [self moveUpAnimation];
//        [numberScrollView setContentOffset:CGPointMake(0, 2 * numberScrollView.bounds.size.height) animated:YES];
    }
}

// show the number in the scroll view with animation or not.
-(void)showNumber:(int)number animated:(BOOL)animated{
    if (animated) {
        currentPage = number - 1;
    }else{
        currentPage = number;
    }
    currentImageView.image = [_numImageArray objectAtIndex: currentPage];
    nextImageView.image = [_numImageArray objectAtIndex: currentPage == 9 ? 0 : currentPage + 1];
    previousImageView.image = [_numImageArray objectAtIndex: currentPage == 0 ? 9 : currentPage - 1];
    if (animated) {
        [self moveUpAnimation];
    }
}

@end

