//
//  LGLazyScrollView.h
//  LittleGhostCore
//
//  Created by gft  on 13-7-19.
//  Copyright (c) 2013年 gft . All rights reserved.
//  有时间再来把这个类补齐吧, 看来以后也许是没机会被齐了, 找了个开源的JTListView
//  现在也暂时没时间写啊, 虽然想自己写了下了.

#import <UIKit/UIKit.h>

@class LGLazyScrollView;

@protocol LGLazyScrollViewDelegate <NSObject>

@optional
- (void)lazyScrollView:(LGLazyScrollView *)lazyScrollView didSelectAtIndex:(NSInteger)index;

@end

@protocol LGLazyScrollViewDataSource <NSObject>

@required
- (UIView *)lazyScrollView:(LGLazyScrollView *)lazyScrollView forIndex:(NSInteger)index;

- (NSInteger)numberOfLazyScrollView:(LGLazyScrollView *)lazyScrollView;

- (CGSize)lazyScrollView:(LGLazyScrollView *)lazyScrollView sizeWithIndex:(NSInteger)index;

@end

@interface LGLazyScrollView : UIView <UIScrollViewDelegate>{
    UIScrollView *_scrollView;
    id <LGLazyScrollViewDataSource> _dataSource;
    id <LGLazyScrollViewDelegate> _delegate;
}

@property (assign, nonatomic) id <LGLazyScrollViewDataSource> dataSource;
@property (assign, nonatomic) id <LGLazyScrollViewDelegate> delegate;

@property(nonatomic,getter=isPagingEnabled)BOOL pagingEnabled;

- (void)jumpToIndex:(NSInteger)index;

@end
