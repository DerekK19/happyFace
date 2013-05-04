//
//  HFFriendsCell.m
//  happyFace
//
//  Created by Derek Knight on 4/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFFriendCell.h"
#import <FacebookSDK/FacebookSDK.h>

@interface HFFriendCell ()

@property (nonatomic) IBOutlet FBProfilePictureView *picture;
@property (nonatomic) IBOutlet UILabel *label;

@end

@implementation HFFriendCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        DEBUGLog(@"Initialise cell");
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
