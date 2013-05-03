//
//  HFLeftMenuCell.m
//  happyFace
//
//  Created by Derek Knight on 2/05/13.
//  Copyright (c) 2013 Derek Knight. All rights reserved.
//

#import "HFLeftMenuCell.h"

@implementation HFLeftMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    NSLog(@"%@ -> %@", self.textLabel.text, value);
    self.textLabel.textColor = RGBColour(195, 203, 219);
    self.textLabel.font = [UIFont systemFontOfSize:18.f];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.text = value;

    [self setNeedsDisplay];
}

- (void)setPicture:(UIImage *)value
{
    [self.imageView setImage:value];

    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(6, 6, 32, 32);
}

- (void)drawRect:(CGRect)rect
{
    UIColor *topColour, *inColour, *bottomColour;
    CGFloat r, g, b, a;
 
    topColour = RGBColour(59, 65, 83);
    if (self.isSelected)
    {
        inColour = RGBColour(42, 46, 61);
    }
    else
    {
        inColour = RGBColour(51, 56, 75);
    }
    bottomColour = RGBColour(42, 47, 62);
    
//    topColour = [UIColor redColor];
//    inColour = [UIColor greenColor];
//    bottomColour = [UIColor yellowColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);
    
    [topColour getRed:&r green:&g blue:&b alpha:&a];
    CGContextSetRGBStrokeColor(context, r, g, b, a);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.f, 0.f);
    CGContextAddLineToPoint(context, rect.size.width, 0.f);
    CGContextStrokePath(context);
    
    [bottomColour getRed:&r green:&g blue:&b alpha:&a];
    CGContextSetRGBStrokeColor(context, r, g, b, a);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.f, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextStrokePath(context);
    
    [inColour getRed:&r green:&g blue:&b alpha:&a];
    CGContextSetRGBFillColor(context, r, g, b, a);
    CGContextFillRect(context, CGRectMake(0.f, 1.f, rect.size.width, rect.size.height-2));

    CGContextRestoreGState(context);
}

@end
