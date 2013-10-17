//
//  LeveyPopListView.m
//  LeveyPopListViewDemo
//
//  Created by Levey on 2/21/12.
//  Copyright (c) 2012 Levey. All rights reserved.
//  用于弹出列表选择页面,类似于Android的选择页面

#import "LGPopListView.h"
#import "LGPopListViewCell.h"

#define POPLISTVIEW_HEADER_HEIGHT 50.
#define RADIUS 5.

@interface LGPopListView (private)
- (void)fadeIn;
- (void)fadeOut;
@end

@implementation LGPopListView
@synthesize delegate;
#pragma mark - initialization & cleaning up
- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions
{
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
    return [self initWithTitle:aTitle options:aOptions frame:rect];
}

- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions frame:(CGRect)rect{
    
    if (self = [super initWithFrame:rect])
    {
        self.backgroundColor = [UIColor clearColor];
        _title = [aTitle copy];
        _options = [aOptions copy];
        
        CGFloat POPLISTVIEW_SCREENINSET_LEFT = self.width/5.0f;
        CGFloat POPLISTVIEW_SCREENINSET_TOP = self.height/9.0f;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(POPLISTVIEW_SCREENINSET_LEFT,
                                                                   POPLISTVIEW_SCREENINSET_TOP + POPLISTVIEW_HEADER_HEIGHT,
                                                                   rect.size.width - 2 * POPLISTVIEW_SCREENINSET_LEFT,
                                                                   rect.size.height - 2 * POPLISTVIEW_SCREENINSET_TOP - POPLISTVIEW_HEADER_HEIGHT - RADIUS)];
        _tableView.separatorColor = [UIColor colorWithWhite:0 alpha:.2];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_options release];
    [_tableView release];
    [super dealloc];
}

#pragma mark - Private Methods
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];

}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

#pragma mark - Tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"PopListViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell ==  nil) {
        cell = [[[LGPopListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity] autorelease];
    }
    int row = [indexPath row];
    cell.imageView.image = [[_options objectAtIndex:row] objectForKey:@"img"];
    cell.textLabel.text = [[_options objectAtIndex:row] objectForKey:@"text"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // tell the delegate the selection
    if (self.delegate && [self.delegate respondsToSelector:@selector(popListView:didSelectedIndex:)]) {
        [self.delegate popListView:self didSelectedIndex:[indexPath row]];
    }
    
    // dismiss self
    [self fadeOut];
}
#pragma mark - TouchTouchTouch
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // tell the delegate the cancellation
    if (self.delegate && [self.delegate respondsToSelector:@selector(leveyPopListViewDidCancel)]) {
        [self.delegate popListViewDidCancel];
    }
    
    // dismiss self
    [self fadeOut];
}

#pragma mark - DrawDrawDraw
- (void)drawRect:(CGRect)rect
{
    CGFloat POPLISTVIEW_SCREENINSET_LEFT = self.width/5.0f;
    CGFloat POPLISTVIEW_SCREENINSET_TOP = self.height/9.0f;
    CGRect bgRect = CGRectInset(rect, POPLISTVIEW_SCREENINSET_LEFT, POPLISTVIEW_SCREENINSET_TOP);
    CGRect titleRect = CGRectMake(POPLISTVIEW_SCREENINSET_LEFT + 10, POPLISTVIEW_SCREENINSET_TOP + 10 + 5,
                                  rect.size.width -  2 * (POPLISTVIEW_SCREENINSET_LEFT + 10), 30);
    CGRect separatorRect = CGRectMake(POPLISTVIEW_SCREENINSET_LEFT, POPLISTVIEW_SCREENINSET_TOP + POPLISTVIEW_HEADER_HEIGHT - 2,
                                      rect.size.width - 2 * POPLISTVIEW_SCREENINSET_LEFT, 2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Draw the background with shadow
    CGContextSetShadowWithColor(ctx, CGSizeZero, 6., [UIColor colorWithWhite:0 alpha:.75].CGColor);
    [[UIColor colorWithWhite:0 alpha:.75] setFill];
    
    
    float x = POPLISTVIEW_SCREENINSET_LEFT;
    float y = POPLISTVIEW_SCREENINSET_TOP;
    float width = bgRect.size.width;
    float height = bgRect.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, x, y + RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y, x + RADIUS, y, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y, x + width, y + RADIUS, RADIUS);
	CGPathAddArcToPoint(path, NULL, x + width, y + height, x + width - RADIUS, y + height, RADIUS);
	CGPathAddArcToPoint(path, NULL, x, y + height, x, y + height - RADIUS, RADIUS);
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);
    
    // Draw the title and the separator with shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithRed:0.020 green:0.549 blue:0.961 alpha:1.] setFill];
    [_title drawInRect:titleRect withFont:[UIFont systemFontOfSize:16.]];
    CGContextFillRect(ctx, separatorRect);
}

@end
