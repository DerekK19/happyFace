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

@interface HFMainViewController () <SASlideMenuDataSource, SASlideMenuDelegate, UITableViewDataSource>
{
}

@end

@implementation HFMainViewController

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
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"HappyFace";
    }
    return @"foo";
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void) tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat brightness = 1-((double) indexPath.row)/5;
    NSInteger section = indexPath.section;
    CGFloat hue=0;
    if (section == 0) {
        hue = 0.0;
    }else if (section==1){
        hue = 0.33;
    }else if (section==2){
        hue = 0.66;
    }
    cell.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:brightness alpha:1.0];
}

-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"item"];
    cell.textLabel.text = @"login";
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
