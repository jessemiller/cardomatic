//
//  Deck.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/25/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "Deck.h"
#import "Card.h"


@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (void)addCard:(Card *)card {
    [self.cards addObject:card];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = [self.cards objectAtIndex:index];
    }
    
    return randomCard;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end
