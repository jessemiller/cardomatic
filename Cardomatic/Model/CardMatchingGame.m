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
@property (strong, nonatomic) NSAttributedString *lastStatus;
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
            self.lastStatus = [self createFlipStringFor:card];
            int matchScore = [self.matcher matchCard:card inCards:self.cards];
            if (self.matcher.consideredAMove) {
                if (matchScore) {
                    int scoreAddition = matchScore * MATCH_BONUS;
                    self.score += scoreAddition;
                    for (Card *otherCard in self.matcher.otherCardsInPlay) {
                        otherCard.unplayable = true;
                    }
                    card.unplayable = true;
                    self.lastStatus = [self createMatchedStringFor:self.matcher.otherCardsInPlay andCard:card withScore:scoreAddition];
                } else {
                    for (Card *otherCard in self.matcher.otherCardsInPlay) {
                        otherCard.faceUp = false;
                    }
                    self.lastStatus = [self createMismatchedStringFor:self.matcher.otherCardsInPlay andCard:card withScore:MISMATCH_PENALTY];
                    self.score -= MISMATCH_PENALTY;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
}

- (NSAttributedString *)createFlipStringFor:(Card *)card {
    NSMutableAttributedString *turnStatus = [[NSMutableAttributedString alloc] initWithString:@"You flipped a "];
    [turnStatus appendAttributedString:card.contents];
    return turnStatus;
}

- (NSAttributedString *)createMatchedStringFor:(NSArray *)otherCardsInPlay andCard:(Card *)card withScore:(int)score {
    NSMutableAttributedString *turnStatus = nil;
    if (otherCardsInPlay.count == 1) {
        Card *otherCard = [otherCardsInPlay lastObject];
        turnStatus = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You matched %@ and %@ for %d points", card.contents.string, otherCard.contents.string,  score]];
    } else {
        turnStatus = [[NSMutableAttributedString alloc] initWithString:@"You matched "];
        [turnStatus appendAttributedString:card.contents];
        for (Card *otherCard in otherCardsInPlay) {
            [turnStatus appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
            [turnStatus appendAttributedString:otherCard.contents];
        }
        [turnStatus appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points", score]]];
    }
    
    return turnStatus;
}

- (NSAttributedString *)createMismatchedStringFor:(NSArray *)otherCardsInPlay andCard:(Card *)card withScore:(int)score {
    NSMutableAttributedString *turnStatus = nil;
    if (otherCardsInPlay.count == 1) {
        Card *otherCard = [otherCardsInPlay lastObject];
        turnStatus = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ and %@ don't match. %d point penalty.", card.contents.string, otherCard.contents.string,  score]];
    } else {
        turnStatus = [[NSMutableAttributedString alloc] initWithAttributedString:card.contents];
        for (Card *otherCard in otherCardsInPlay) {
            [turnStatus appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
            [turnStatus appendAttributedString:otherCard.contents];
        }
        [turnStatus appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match. %d point penalty.", score]]];
    }
    
    return turnStatus;
}

- (NSUInteger)cardsInPlay {
    return [self.cards count];
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end
