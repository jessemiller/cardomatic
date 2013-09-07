//
//  CardMatchingGame.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/31/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCardMatcher.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *lastStatus;
@property (strong, nonatomic) PlayingCardMatcher *matcher;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck usingMatcher:(PlayingCardMatcher *)matcher {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            self.cards[i] = [deck drawRandomCard];
        }
        self.matcher = matcher;
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
            int matchScore = [self.matcher matchCard:card inCards:self.cards];
            if (self.matcher.consideredAMove) {
                if (matchScore) {
                    int scoreAddition = matchScore * MATCH_BONUS;
                    self.score += scoreAddition;
                    for (Card *otherCard in self.matcher.otherCardsInPlay) {
                        otherCard.unplayable = true;
                        self.lastStatus = [NSString stringWithFormat:@"You matched %@ and %@ for %d points", card.contents, otherCard.contents, scoreAddition];
                    }
                    card.unplayable = true;
                } else {
                    for (Card *otherCard in self.matcher.otherCardsInPlay) {
                        otherCard.faceUp = false;
                        self.lastStatus = [NSString stringWithFormat:@"%@ and %@ don't match. %d point penalty.", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    self.score -= MISMATCH_PENALTY;
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
