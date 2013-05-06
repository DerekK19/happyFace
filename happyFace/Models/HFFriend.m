//
//  HFFriend.m
//  happyFace
//
//  Created by Derek Knight on 5/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFFriend.h"

@implementation HFFriend

- (id)initWithIdentifier:(NSString *)identifier andName:(NSString *)name
{
    self = [self init];
    if (self)
    {
        _identifier = identifier;
        _name = name;
    }
    return self;
}

@end
