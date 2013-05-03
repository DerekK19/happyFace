//
//  HFLeftMenuHeader.m
//  happyFace
//
//  Created by Derek Knight on 3/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFLeftMenuHeader.h"

@implementation HFLeftMenuHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *colourHi;
    UIColor *colourLo;

    colourHi  = RGBColour(68, 73, 92);
    colourLo  = RGBColour(59, 64, 83);
    
    CGFloat r1, r2, g1, g2, b1, b2, a1, a2;
    [colourHi getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [colourLo getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace,
                                                                 (const CGFloat[8]){r1, g1, b1, a1, r2, g2, b2, a2},
                                                                 (const CGFloat[2]){0.0f,1.0f},
                                                                 2);
    
    CGContextDrawLinearGradient(context,
                                gradient,
                                CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds)),
                                CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds)),
                                0);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
}

@end
