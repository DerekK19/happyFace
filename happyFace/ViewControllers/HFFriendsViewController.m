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
#import "HFFriend.h"
#import <FacebookSDK/FacebookSDK.h>

static NSString * const FriendCellIdentifier = @"friendCell";

@interface HFFriendsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *_friends;
}

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
    
    _friends = [[NSMutableArray alloc]init];
    for (int i = 0; i < 27; i++) [_friends addObject:[[NSMutableArray alloc]init]];
    
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSArray* friends = [result objectForKey:@"data"];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        friends = [friends sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        DEBUGLog(@"Found: %i friends", friends.count);
        for (NSDictionary<FBGraphUser>* friend in friends) {
            DEBUGLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
            int section = [[friend.name lowercaseString] characterAtIndex:0] - 'a';
            if (section < 0 || section > 26) section = 26;
            [[_friends objectAtIndex:section] addObject:[[HFFriend alloc]initWithIdentifier:friend.id
                                                                                    andName:friend.name]];
        }
        [self.collectionView reloadData];
    }];
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
    DEBUGLog(@"There are 27 sections");
    return 27;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    int count = [[_friends objectAtIndex:section] count];
    DEBUGLog(@"There are %d items in section %d", count, section);
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DEBUGLog(@"Get cell for section %d, item %d", indexPath.section, indexPath.row);
    HFFriendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FriendCellIdentifier
                                                                   forIndexPath:indexPath];
    cell.model = [[_friends objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

@end
