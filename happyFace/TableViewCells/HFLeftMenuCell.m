//
//  HFLeftMenuCell.m
//  happyFace
//
//  Created by Derek Knight on 2/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFLeftMenuCell.h"

@interface HFLeftMenuCell ()

@property (nonatomic) IBOutlet UIImageView *menuPicture;
@property (nonatomic) IBOutlet UILabel *menuTitle;

@end

@implementation HFLeftMenuCell

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

- (void)setTitle:(NSString *)value
{
    _menuTitle.text = value;

    [self setNeedsDisplay];
}

- (void)setPicture:(UIImage *)value
{
    _menuPicture.image = value;

    [self setNeedsDisplay];
}

@end
