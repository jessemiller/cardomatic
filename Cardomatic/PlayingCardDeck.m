//
//  PlayingCardDeck.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/25/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init {
    self = [super init];
    
    if (self) {
        for (int rank=0; rank <= [PlayingCard maxRank]; rank++) {
            for (NSString *suit in [PlayingCard validSuits]) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
