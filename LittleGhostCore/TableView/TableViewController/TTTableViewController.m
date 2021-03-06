//
//  TTTableViewController.m
//  MyVideo
//
//  Created by gft  on 13-5-30.
//  Copyright (c) 2013年 gft . All rights reserved.
//

#import "TTTableViewController.h"
#import "TTTableViewVarHeightDelegate.h"
#import "TTTableViewDelegate.h"

@interface TTTableViewController ()

@end

@implementation TTTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = nil;
    _clearsSelectionOnViewWillAppear = YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewStyle)style {
	self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _tableViewStyle = style;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    if (_clearsSelectionOnViewWillAppear) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    }
}

- (void)reloadTableViewData{
    [self updateTableDelegate];
    self.tableView.dataSource = _dataSource;
    [self.tableView reloadData];
}

- (void)setDataSource:(id<TTTableViewDataSource>)dataSource{
    if (dataSource != _dataSource) {
        [_dataSource release];
        _dataSource = [dataSource retain];
        self.tableView.dataSource = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateTableDelegate {
    if (!self.tableView.delegate) {
        [_tableDelegate release];
        _tableDelegate = [[self createDelegate] retain];
        
        // You need to set it to nil before changing it or it won't have any effect
        self.tableView.delegate = nil;
        self.tableView.delegate = _tableDelegate;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    if (_variableHeightRows) {
        return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
        
    } else {
        return [[[TTTableViewDelegate alloc] initWithController:self] autorelease];
    }
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath{
    
}

- (void)didBeginDragging{
    
}

- (void)didEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

- (void)didEndDecelerating{
    
}

- (void)didScrollToTop{
    
}

- (void)tableViewDidScroll:(UIScrollView *)tableView{
    
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView*)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        _tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleHeight;
        
        UIColor* separatorColor = _tableViewStyle == UITableViewStyleGrouped
        ? TTSTYLEVAR(tableGroupedCellSeparatorColor)
        : TTSTYLEVAR(tablePlainCellSeparatorColor);
        if (separatorColor) {
            _tableView.separatorColor = separatorColor;
        }
        
        _tableView.separatorStyle = _tableViewStyle == UITableViewStyleGrouped
        ? TTSTYLEVAR(tableGroupedCellSeparatorStyle)
        : TTSTYLEVAR(tablePlainCellSeparatorStyle);
        
        UIColor* backgroundColor = _tableViewStyle == UITableViewStyleGrouped
        ? TTSTYLEVAR(tableGroupedBackgroundColor)
        : TTSTYLEVAR(tablePlainBackgroundColor);
        if (backgroundColor) {
            _tableView.backgroundColor = backgroundColor;
            self.view.backgroundColor = backgroundColor;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTableView:(UITableView*)tableView {
    if (tableView != _tableView) {
        [_tableView release];
        _tableView = [tableView retain];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    TT_RELEASE_SAFELY(_tableDelegate);
    TT_RELEASE_SAFELY(_dataSource);
    [super dealloc];
}

@end
