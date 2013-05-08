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

@property (nonatomic) IBOutlet UIImageView *picture;
@property (nonatomic) IBOutlet UILabel *label;

@end

@implementation HFFriendCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setModel:(HFFriend *)model
{
    _label.text = model.name;
    _picture.image = model.picture;
//    [model addObserver:self
//            forKeyPath:@"picture"
//               options:0
//               context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context
//{
//    if ([keyPath isEqualToString:@"picture"])
//    {
//        DEBUGLog(@"picture changed");
//        [_model removeObserver:self forKeyPath:keyPath];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)prepareForReuse
{
    _label.text = nil;
    _picture.image = nil;
}

@end
