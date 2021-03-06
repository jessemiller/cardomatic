//
//  CardMatchingGame.h
//  Cardomatic
//
//  Created by Jesse Miller on 8/31/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "PlayingCardMatcher.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck usingMatcher:(id <CardMatcher>)matcher;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)removeCardAtIndex:(NSUInteger)index;
- (void)addCards:(NSUInteger)cardCount;
- (NSUInteger)cardsInPlay;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic, readonly) NSAttributedString *lastStatus;

@end
