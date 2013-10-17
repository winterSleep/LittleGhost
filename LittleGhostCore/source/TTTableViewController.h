//
//  TTTableViewController.h
//  MyVideo
//
//  Created by gft  on 13-5-30.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTableViewDataSource.h"

@interface TTTableViewController : UITableViewController{
    id <TTTableViewDataSource> _dataSource;
    id <UITableViewDelegate> _tableDelegate;
    BOOL _variableHeightRows;
    BOOL _showTableShadows;
}

@property (retain, nonatomic)id <TTTableViewDataSource> dataSource;

/**
 * Indicates if the table should support non-fixed row heights.
 */
@property (nonatomic) BOOL variableHeightRows;

/**
 * When enabled, draws gutter shadows above the first table item and below the last table item.
 *
 * Known issues: When there aren't enough cell items to fill the screen, the table view draws
 * empty cells for the remaining space. This causes the bottom shadow to appear out of place.
 */
@property (nonatomic) BOOL showTableShadows;

- (void)reloadTableViewData;

/**
 * Creates an delegate for the table view.
 *
 * Subclasses can override this to provide their own table delegate implementation.
 */
- (id<UITableViewDelegate>)createDelegate;

/**
 * Tells the controller that the user selected an object in the table.
 *
 * By default, the object's URLValue will be opened in TTNavigator, if it has one. If you don't
 * want this to be happen, be sure to override this method and be sure not to call super.
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Tells the controller that the user began dragging the table view.
 */
- (void)didBeginDragging;

/**
 * Tells the controller that the user stopped dragging the table view.
 */
- (void)didEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)didEndDecelerating;

- (void)didScrollToTop;

- (void)tableViewDidScroll:(UIScrollView *)tableView;

@end
