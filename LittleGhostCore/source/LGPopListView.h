//
//  LeveyPopListView.h
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//


@protocol LGPopListViewDelegate;
@interface LGPopListView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSString *_title;
    NSArray *_options;
}

@property (nonatomic, assign) id<LGPopListViewDelegate> delegate;

// The options is a NSArray, contain some NSDictionaries, the NSDictionary contain 2 keys, one is "img", another is "text".
- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions;

- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions frame:(CGRect)rect;

// If animated is YES, PopListView will be appeared with FadeIn effect.
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end

@protocol LGPopListViewDelegate <NSObject>

@optional

- (void)popListView:(LGPopListView *)popListView didSelectedIndex:(NSInteger)anIndex;

- (void)popListViewDidCancel;

@end