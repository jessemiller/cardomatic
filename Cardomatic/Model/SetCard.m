//
//  SetCard.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/4/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSAttributedString *)contents {
    NSDictionary *cardAttributes = nil;
    if ([self.shading isEqual: @"solid"]) {
        cardAttributes = @{ NSForegroundColorAttributeName: self.color };
    } else if ([self.shading isEqualToString: @"outlined"]) {
        cardAttributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                            NSStrokeWidthAttributeName: @-5,
                            NSStrokeColorAttributeName: self.color};
    } else if ([self.shading isEqualToString: @"striped"]) {
        cardAttributes = @{ NSForegroundColorAttributeName: self.color,
                            NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) };
    }
    
    NSAttributedString *cardContents = [[NSAttributedString alloc] initWithString:[self shapeString] attributes:cardAttributes];
    return cardContents;
}

- (NSString *)shapeString {
    if (self.number == 1) {
        return self.shape;
    } else if (self.number == 2) {
        return [NSString stringWithFormat:@"%@%@", self.shape, self.shape];
    } else if (self.number == 3) {
        return [NSString stringWithFormat:@"%@%@%@", self.shape, self.shape, self.shape];
    }
    return @"?";
}

+ (NSArray *)validShapes {
    return @[@"●", @"■", @"▲"];
}

+ (NSArray *)validColors {
    return @[[UIColor redColor], [UIColor purpleColor], [UIColor greenColor]];
}

+ (NSArray *)validShading {
    return @[@"solid", @"striped", @"outlined"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

@end
