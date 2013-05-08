//
//  HFFriend.h
//  happyFace
//
//  Created by Derek Knight on 5/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFFriend : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) UIImage *picture;

- (id)initWithName:(NSString *)name;
@end
