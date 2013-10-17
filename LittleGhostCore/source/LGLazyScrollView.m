//
//  LGLazyScrollView.m
//  LittleGhostCore
//
//  Created by gft  on 13-7-19.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import "LGLazyScrollView.h"

@implementation LGLazyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setDelegate:self];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setPagingEnabled:(BOOL)pagingEnabled{
    _pagingEnabled = pagingEnabled;
    _scrollView.pagingEnabled = pagingEnabled;
}

- (void)jumpToIndex:(NSInteger)index{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    DLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    DLog(@"scrollViewDidEndDragging");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    DLog(@"scrollViewWillBeginDecelerating");
}// called on finger up as we are moving

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    DLog(@"scrollViewDidEndDecelerating");
}// called when scroll view grinds to a halt

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    DLog(@"scrollViewDidEndScrollingAnimation");
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_scrollView setFrame:self.bounds];
}

- (void)dealloc{
    _delegate = nil;
    _dataSource = nil;
    TT_RELEASE_SAFELY(_scrollView);
    [super dealloc];
}

@end
