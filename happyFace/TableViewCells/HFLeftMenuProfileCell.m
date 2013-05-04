//
//  HFLeftMenuProfileCell.m
//  happyFace
//
//  Created by Derek Knight on 4/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFLeftMenuProfileCell.h"
#import <FacebookSDK/FacebookSDK.h>

@interface HFLeftMenuProfileCell ()

@property (nonatomic) IBOutlet FBProfilePictureView *profilePicture;
@property (nonatomic) IBOutlet UILabel *profileName;

@end

@implementation HFLeftMenuProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    [self setNeedsDisplay];
}

- (void)setUserName:(NSString *)userName
{
    _profileName.text = userName;
    
    [self setNeedsDisplay];
}

- (void)setProfileId:(NSString *)profileId
{
    _profilePicture.profileID = profileId;;
    
    [self setNeedsDisplay];
}

@end
