//
//  SetDeck.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/7/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (id)init {
    self = [super init];
    
    if (self) {
        for (int number = 1; number <= [SetCard maxNumber]; number++) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSString *shading in [SetCard validShading]) {
                    for (UIColor *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.shape = shape;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
