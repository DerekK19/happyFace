//
//  HFFriendsViewController.m
//  happyFace
//
//  Created by Derek Knight on 4/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFFriendsViewController.h"
#import "HFFriendsLayout.h"
#import "HFFriendCell.h"

static NSString * const FriendCellIdentifier = @"friendCell";

@interface HFFriendsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) IBOutlet HFFriendsLayout *friendsLayout;

@end

@implementation HFFriendsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        DEBUGLog(@"Initialise friends controller");
        // Can't reference self.super.collectionView or super.collectionView here
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        _friendsLayout.numberOfColumns = 5;
        
        // handle insets for iPhone 4 or 5
        CGFloat sideInset = [UIScreen mainScreen].preferredMode.size.width == 1136.0f ?
        45.0f : 25.0f;
        
        _friendsLayout.itemInsets = UIEdgeInsetsMake(22.0f, sideInset, 13.0f, sideInset);
        
    } else {
        _friendsLayout.numberOfColumns = 3;
        _friendsLayout.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    DEBUGLog(@"There are 26 sections");
    return 26;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    DEBUGLog(@"There are 5 items in section %d", section);
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DEBUGLog(@"Get cell for section %d, item %d", indexPath.section, indexPath.row);
    HFFriendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FriendCellIdentifier
                                                                   forIndexPath:indexPath];
    
    return cell;
}

@end
