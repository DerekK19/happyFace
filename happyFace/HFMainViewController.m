//
//  HFViewController.m
//  happyFace
//
//  Created by Derek Knight on 24/04/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFMainViewController.h"
#import "HFAppDelegate.h"
#import "HFLoginViewController.h"
#import "SASlideMenuDataSource.h"
#import "SASlideMenuDelegate.h"

#define RGBColour(r,g,b) [UIColor colorWithRed:((CGFloat)r)/255.f green:((CGFloat)g)/255.f blue:((CGFloat)b)/255.f alpha:1.f]

@interface HFMainViewController () <SASlideMenuDataSource, SASlideMenuDelegate, UITableViewDataSource>
{
}

@property (nonatomic, strong) NSArray *menuSections;
@end

@implementation HFMainViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _menuSections = @[@"", @"FAVOURITES", @"APPS", @"GROUPS", @"FRIENDS", @" "];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SASlideMenuDataSource

-(void) prepareForSwitchToContentViewController:(UINavigationController *)content
{
    UIViewController* controller = [content.viewControllers objectAtIndex:0];
    if ([controller isKindOfClass:[HFLoginViewController class]])
    {
//        HFLoginViewController *loginViewController = (HFLoginViewController *)controller;
    }
}

// It configure the menu button. The beahviour of the button should not be modified
-(void) configureMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuicon.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

// It configure the right menu button. The beahviour of the button should not be modified
-(void) configureRightMenuButton:(UIButton *)menuButton{
    menuButton.frame = CGRectMake(0, 0, 40, 29);
    [menuButton setImage:[UIImage imageNamed:@"menuright.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuhighlighted.png"] forState:UIControlStateHighlighted];
    [menuButton setAdjustsImageWhenHighlighted:NO];
    [menuButton setAdjustsImageWhenDisabled:NO];
}

// This is the segue you want visibile when the controller is loaded the first time
-(NSIndexPath*) selectedIndexPath
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

// It maps each indexPath to the segueId to be used. The segue is performed only the first time the controller needs to loaded, subsequent switch to the content controller will use the already loaded controller

-(NSString*) segueIdForIndexPath:(NSIndexPath *)indexPath
{
    return @"login";
}

- (NSString *)initialSegueId
{
    return @"login";
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _menuSections.count;
}

-(NSString*)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return [_menuSections objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [[_menuSections objectAtIndex:section] length] == 0 ? 0.f : 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat height = 40.f;
    CGFloat width = tableView.frame.size.width;
    CGFloat marginX = 10.f;
    CGFloat marginY = 5.f;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, width, height)];
    headerView.backgroundColor = RGBColour(63, 70, 89);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(marginX, marginY, width-2*marginX, height-2*marginY)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGBColour(156, 164, 179);
    label.font = [UIFont boldSystemFontOfSize:12.f];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerView addSubview:label];

    return headerView;
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void) tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.isSelected == YES)
    {
        [cell setBackgroundColor:RGBColour(41, 47, 61)];
    }
    else
    {
        [cell setBackgroundColor:RGBColour(50, 57, 74)];
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"item"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"login";
    cell.textLabel.textColor = RGBColour(156, 164, 179);
    return cell;
}

-(CGFloat) leftMenuVisibleWidth
{
    return 200.f;
}

-(CGFloat) rightMenuVisibleWidth
{
    return 300.f;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:RGBColour(41, 47, 61)];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:RGBColour(50, 57, 74)];
}

#pragma mark -
#pragma mark SASlideMenuDelegate

-(void) slideMenuWillSlideIn
{
    NSLog(@"slideMenuWillSlideIn");
}
-(void) slideMenuDidSlideIn
{
    NSLog(@"slideMenuDidSlideIn");
}
-(void) slideMenuWillSlideToSide
{
    NSLog(@"slideMenuWillSlideToSide");
}
-(void) slideMenuDidSlideToSide
{
    NSLog(@"slideMenuDidSlideToSide");
}
-(void) slideMenuWillSlideOut
{
    NSLog(@"slideMenuWillSlideOut");
}
-(void) slideMenuDidSlideOut
{
    NSLog(@"slideMenuDidSlideOut");
}
-(void) slideMenuWillSlideToLeft
{
    NSLog(@"slideMenuWillSlideToLeft");
}
-(void) slideMenuDidSlideToLeft
{
    NSLog(@"slideMenuDidSlideToLeft");
}

@end
