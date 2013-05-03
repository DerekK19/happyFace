//
//  HFViewController.m
//  happyFace
//
//  Created by Derek Knight on 24/04/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFLeftMenuViewController.h"
#import "HFLeftMenuHeader.h"
#import "HFLeftMenuCell.h"
#import "HFAppDelegate.h"
#import "HFLoginViewController.h"
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"

@interface HFLeftMenuViewController () <SASlideMenuDataSource, SASlideMenuDelegate, UITableViewDataSource>
{
    HFLeftMenuCell *_userCell;
}

@property (nonatomic, strong) NSDictionary *menu;
@property (nonatomic, strong) NSArray *menuSections;

- (void)setUser:(NSDictionary<FBGraphUser>*)user;

@end

@implementation HFLeftMenuViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _menuSections = @[@"", @"FAVOURITES", @"APPS", @"GROUPS", @"FRIENDS", @" "];
        _menu = @{@"sections":@[
                                @{@"title"   : @"",
                                  @"entries" : @[@{@"title"  : @"Sign In",
                                                   @"image"  : @"placeholder.png",
                                                   @"segue"  : @"login"}]},
                                @{@"title"   : @"FAVOURITES",
                                  @"entries" : @[@{@"title"  : @"News Feed",
                                                   @"segue"  : @"news-feed"},
                                                 @{@"title"  : @"Messages",
                                                   @"segue"  : @"news-feed"},
                                                 @{@"title"  : @"Nearby",
                                                   @"segue"  : @"news-feed"},
                                                 @{@"title"  : @"Events",
                                                   @"segue"  : @"news-feed"},
                                                 @{@"title"  : @"Friends",
                                                   @"segue"  : @"news-feed"}]},
                                @{@"title"   : @"APPS",
                                  @"entries" : @[]},
                                @{@"title"   : @"GROUPS",
                                  @"entries" : @[]},
                                @{@"title"   : @"FRIENDS",
                                  @"entries" : @[]},
                                @{@"title"   : @" ",
                                  @"entries" : @[@{@"title"  : @"Sign Out",
                                                   @"segue"  : @"logout"}]}
                                ]};
        [[NSNotificationCenter defaultCenter]addObserverForName:NOTIFY_USER_LOGGED_IN
                                                         object:nil
                                                          queue:nil
                                                     usingBlock:^(NSNotification *note)
                                                                {
                                                                    NSDictionary<FBGraphUser> *user = note.object;
                                                                    [self setUser:user];
                                                                    [self performSegueWithIdentifier:@"news-feed"
                                                                                              sender:self];
                                                                }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.sectionFooterHeight = 0.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Private functions

- (void)setUser:(NSDictionary<FBGraphUser>*)user
{
//    HFLeftMenuCell *cell = (HFLeftMenuCell *)[self tableView:self.tableView
//                                       cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
//                                                                                inSection:0]];
    [_userCell setTitle:user.name];
//    [cell setNeedsDisplay];
}

#pragma mark -
#pragma mark SASlideMenuDataSource

-(void) prepareForSwitchToContentViewController:(UINavigationController *)content
{
    UIViewController* controller = [content.viewControllers objectAtIndex:0];
    if ([controller isKindOfClass:[HFLoginViewController class]])
    {
        HFLoginViewController *loginViewController = (HFLoginViewController *)controller;
    }
}

// It configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton
{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

// It configure the right menu button. The beahviour of the button should not be modified
-(void) configureRightMenuButton:(UIButton *)menuButton
{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuright.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

// This is the segue you want visible when the controller is loaded the first time
-(NSIndexPath*) selectedIndexPath
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

// It maps each indexPath to the segueId to be used. The segue is performed only the first time the controller needs to loaded, subsequent switch to the content controller will use the already loaded controller

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *subMenu = [((NSArray *)([_menu objectForKey:@"sections"])) objectAtIndex:indexPath.section];
    NSArray *entries = [subMenu objectForKey:@"entries"];
    NSDictionary *entry = [entries objectAtIndex:indexPath.row];
    
    return [entry objectForKey:@"segue"];
}

- (NSString *)initialSegueId
{
    return @"login";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    UIViewController *dest = [segue destinationViewController];
    NSString *name = [segue identifier];
    DEBUGLog(@"prepareForSegue %@ %@ %@", segue, dest, name);
    
    if ([dest isKindOfClass:[UINavigationController class]])
    {
        UIViewController *controller = [((UINavigationController *)dest).viewControllers objectAtIndex:0];
        if ([controller conformsToProtocol:@protocol(HFContentViewProtocol)])
        {
            DEBUGLog(@"Pass parameter '%@'", name);
            [(NSObject<HFContentViewProtocol>*)controller setSegueIdentifier:name];
        }
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return ((NSArray *)([_menu objectForKey:@"sections"])).count;
}

-(NSString*)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *subMenu = [((NSArray *)([_menu objectForKey:@"sections"])) objectAtIndex:section];
    return [subMenu objectForKey:@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *subMenu = [((NSArray *)([_menu objectForKey:@"sections"])) objectAtIndex:section];
    return [[subMenu objectForKey:@"title"] length] == 0 ? 0.f : 36.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = 36.f;
    CGFloat width = tableView.frame.size.width;
    CGFloat marginX = 10.f;
    CGFloat marginY = 5.f;
    
    HFLeftMenuHeader *headerView = [[HFLeftMenuHeader alloc]initWithFrame:CGRectMake(0.f, 0.f, width, height)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(marginX, marginY, width-2*marginX, height-2*marginY)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBColour(157, 161, 178);
    label.font = [UIFont boldSystemFontOfSize:12.f];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerView addSubview:label];

    return headerView;
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *subMenu = [((NSArray *)([_menu objectForKey:@"sections"])) objectAtIndex:section];
    NSArray *entries = [subMenu objectForKey:@"entries"];
    return entries.count;
}

-(void) tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView:willDisplayCell %@ %d %d", cell, indexPath.section, indexPath.row);
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *subMenu = [((NSArray *)([_menu objectForKey:@"sections"])) objectAtIndex:indexPath.section];
    NSArray *entries = [subMenu objectForKey:@"entries"];
    NSDictionary *entry = [entries objectAtIndex:indexPath.row];
    NSString *title = [entry objectForKey:@"title"];

    static NSString *cellIdentifier = @"leftMenuCell";
    HFLeftMenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setTitle:title];
    [cell setPicture:[UIImage imageNamed:[entry objectForKey:@"image"]]];
    
    if (indexPath.section == 0 && indexPath.row == 0) _userCell = cell;
    
    return cell;
}

-(CGFloat) leftMenuVisibleWidth
{
    return 304.f;
}

-(CGFloat) rightMenuVisibleWidth
{
    return 200.f;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];

    NSDictionary *subMenu = [((NSArray *)([_menu objectForKey:@"sections"])) objectAtIndex:indexPath.section];
    NSArray *entries = [subMenu objectForKey:@"entries"];
    NSDictionary *entry = [entries objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:[entry objectForKey:@"segue"]
                              sender:self];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark -
#pragma mark SASlideMenuDelegate

-(void) slideMenuWillSlideIn
{
    DEBUGLog(@"slideMenuWillSlideIn");
}
-(void) slideMenuDidSlideIn
{
    DEBUGLog(@"slideMenuDidSlideIn");
}
-(void) slideMenuWillSlideToSide
{
    DEBUGLog(@"slideMenuWillSlideToSide");
}
-(void) slideMenuDidSlideToSide
{
    DEBUGLog(@"slideMenuDidSlideToSide");
}
-(void) slideMenuWillSlideOut
{
    DEBUGLog(@"slideMenuWillSlideOut");
}
-(void) slideMenuDidSlideOut
{
    DEBUGLog(@"slideMenuDidSlideOut");
}
-(void) slideMenuWillSlideToLeft
{
    DEBUGLog(@"slideMenuWillSlideToLeft");
}
-(void) slideMenuDidSlideToLeft
{
    DEBUGLog(@"slideMenuDidSlideToLeft");
}

@end
