//
//  SetCardView.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/14/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#define CARD_CORNER_RADIUS 12.0
#define OVAL_CORNER_RADIUS 10.0
#define SHAPE_WIDTH 8.0
#define SHAPE_HEIGHT 30.0
#define SHAPE_SPACING 2.0
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CARD_CORNER_RADIUS];
    
    [roundedRect addClip];
    
    if (self.faceUp) {
        [[UIColor yellowColor] setFill];
    } else {
        [[UIColor whiteColor] setFill];
    }
    
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.number == 1) {
        [self drawShape];
    } else if (self.number == 2) {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSaveGState(c);
        CGContextTranslateCTM(c, 0 - (SHAPE_WIDTH / 2), 0);
        [self drawShape];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
        c = UIGraphicsGetCurrentContext();
        CGContextSaveGState(c);
        CGContextTranslateCTM(c, (SHAPE_WIDTH / 2) + SHAPE_SPACING, 0);
        [self drawShape];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
    } else if (self.number == 3) {
        [self drawShape];
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSaveGState(c);
        CGContextTranslateCTM(c, 0 - SHAPE_WIDTH - SHAPE_SPACING, 0);
        [self drawShape];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());
        c = UIGraphicsGetCurrentContext();
        CGContextSaveGState(c);
        CGContextTranslateCTM(c, SHAPE_WIDTH + SHAPE_SPACING, 0);
        [self drawShape];
        CGContextRestoreGState(UIGraphicsGetCurrentContext());            
    }
    
}

- (void)drawShape {
    UIBezierPath *shape;
    if ([self.shape isEqual: @"oval"]) {
        shape = [self ovalBezierPath];
    } else if ([self.shape isEqual: @"diamond"]) {
        shape = [self diamondBezierPath];
    } else if ([self.shape isEqual: @"squiggle"]) {
        shape = [self squiggleBezierPath];
    }
    [self.color setStroke];
    [shape stroke];
    if ([self.shading isEqual: @"solid"]) {
        [self.color setFill];
        [shape fill];
    } else if ([self.shading isEqual: @"striped"]) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [shape addClip];
        for (CGFloat y=0.0; y <= self.bounds.size.height; y += 4.0) {
            CGContextMoveToPoint(context, 0, y);
            CGContextAddLineToPoint(context, self.bounds.size.width, y);
        }
        CGContextStrokePath(context);
    }    
}

- (UIBezierPath *)ovalBezierPath {
    CGRect ovalCG;
    ovalCG.origin = CGPointMake((self.bounds.size.width / 2) - (SHAPE_WIDTH / 2), (self.bounds.size.height / 2) - (SHAPE_HEIGHT / 2));
    ovalCG.size = CGSizeMake(SHAPE_WIDTH, SHAPE_HEIGHT);
    
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:ovalCG cornerRadius:OVAL_CORNER_RADIUS];
    return oval;
}

- (UIBezierPath *)diamondBezierPath {
    UIBezierPath *diamond = [UIBezierPath bezierPath];
    [diamond moveToPoint:CGPointMake((self.bounds.size.width / 2) - (SHAPE_WIDTH / 2), (self.bounds.size.height / 2))];
    [diamond addLineToPoint:CGPointMake((self.bounds.size.width/2), (self.bounds.size.height / 2) - (SHAPE_HEIGHT / 2))];
    [diamond addLineToPoint:CGPointMake((self.bounds.size.width / 2) + (SHAPE_WIDTH / 2), (self.bounds.size.height / 2))];
    [diamond addLineToPoint:CGPointMake((self.bounds.size.width/2), (self.bounds.size.height / 2) + (SHAPE_HEIGHT / 2))];
    [diamond closePath];
    return diamond;
}

- (UIBezierPath *)squiggleBezierPath {
    UIBezierPath *squiggle = [UIBezierPath bezierPath];
    [squiggle moveToPoint:CGPointMake((self.bounds.size.width / 2) - (SHAPE_WIDTH / 2), (self.bounds.size.height / 2) - (SHAPE_HEIGHT / 2))];
    [squiggle addQuadCurveToPoint:CGPointMake((self.bounds.size.width / 2) + (SHAPE_WIDTH / 2), (self.bounds.size.height / 2) - (SHAPE_HEIGHT / 2)) controlPoint: CGPointMake((self.bounds.size.width / 2), (self.bounds.size.height / 2) - SHAPE_HEIGHT)];
    [squiggle addCurveToPoint:CGPointMake((self.bounds.size.width / 2) + (SHAPE_WIDTH / 2), (self.bounds.size.height / 2) + (SHAPE_HEIGHT / 2))
                controlPoint1:CGPointMake((self.bounds.size.width / 2), (self.bounds.size.height / 2))
                controlPoint2:CGPointMake((self.bounds.size.width / 2) + SHAPE_WIDTH, (self.bounds.size.height / 2))];
    [squiggle addQuadCurveToPoint:CGPointMake((self.bounds.size.width /2) - (SHAPE_WIDTH /2), (self.bounds.size.height / 2) + (SHAPE_HEIGHT / 2)) controlPoint: CGPointMake((self.bounds.size.width / 2), (self.bounds.size.height / 2) + SHAPE_HEIGHT)];
    [squiggle addCurveToPoint:CGPointMake((self.bounds.size.width / 2) - (SHAPE_WIDTH / 2), (self.bounds.size.height / 2) - (SHAPE_HEIGHT / 2))
                controlPoint1:CGPointMake((self.bounds.size.width / 2), (self.bounds.size.height / 2))
                controlPoint2:CGPointMake((self.bounds.size.width / 2) - SHAPE_WIDTH, (self.bounds.size.height / 2))];
    return squiggle;
}

- (void)setShape:(NSString *)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number {
    _number = number;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

@end
