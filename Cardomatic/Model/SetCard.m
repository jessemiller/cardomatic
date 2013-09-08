//
//  SetCard.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/4/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if (otherCards.count == 2) {
        SetCard *firstCard = otherCards[0];
        SetCard *secondCard = otherCards[1];
        
        if ((((self.number == firstCard.number) && (self.number == secondCard.number)) ||
             ((self.number != firstCard.number) && (self.number != secondCard.number) && (firstCard.number != secondCard.number))) &&
            (([self.shape isEqual:firstCard.shape] && [self.shape isEqual:secondCard.shape]) ||
             (![self.shape isEqual:firstCard.shape] && ![self.shape isEqual:secondCard.shape] && ![firstCard.shape isEqual:secondCard.shape])) &&
            (([self.color isEqual:firstCard.color] && [self.color isEqual:secondCard.color]) ||
             (![self.color isEqual:firstCard.color] && ![self.color isEqual:secondCard.color] && ![firstCard.color isEqual:secondCard.color])) &&
            (([self.shading isEqual:firstCard.shading] && [self.shading isEqual:secondCard.shading]) ||
             (![self.shading isEqual:firstCard.shading] && ![self.shading isEqual:secondCard.shading] && ![firstCard.shading isEqual:secondCard.shading])))
        {
            score = 2;
        }
    }
    
    return score;
}

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
