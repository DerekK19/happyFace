//
//  HFAppDelegate.h
//  happyFace
//
//  Created by Derek Knight on 24/04/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class HFViewController;
@class HFLoginViewController;

@interface HFAppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) HFViewController *mainViewController;

@property (strong, nonatomic) HFLoginViewController* loginViewController;

@property BOOL isNavigating;

@end
