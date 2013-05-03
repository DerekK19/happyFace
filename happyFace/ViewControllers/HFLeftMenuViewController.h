//
//  HFViewController.h
//  happyFace
//
//  Created by Derek Knight on 24/04/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASlideMenuViewController.h"

@interface HFLeftMenuViewController : SASlideMenuViewController

@end

@protocol HFContentViewProtocol <NSObject>

@required
- (void)setSegueIdentifier:(NSString *)name;

@end