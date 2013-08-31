//
//  CardMatchingGame.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/31/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastStatus;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            self.cards[i] = [deck drawRandomCard];
        }
    }
    
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    self.lastStatus = nil;
    if (!card.unplayable) {
        if (!card.faceUp) {
            self.lastStatus = [NSString stringWithFormat:@"You flipped a %@", card.contents];
            for (Card *otherCard in self.cards) {
                if (otherCard.faceUp && !otherCard.unplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = true;
                        card.unplayable = true;
                        int scoreAddition = matchScore * MATCH_BONUS;
                        self.score += scoreAddition;
                        self.lastStatus = [NSString stringWithFormat:@"You matched %@ and %@ for %d points", card.contents, otherCard.contents, scoreAddition];
                    } else {
                        otherCard.faceUp = false;
                        self.score -= MISMATCH_PENALTY;
                        self.lastStatus = [NSString stringWithFormat:@"%@ and %@ don't match. %d point penalty.", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end
