//
//  PlayingCardMatcher.h
//  Cardomatic
//
//  Created by Jesse Miller on 9/7/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@protocol CardMatcher

@property (nonatomic, strong) NSMutableArray *otherCardsInPlay;
@property BOOL consideredAMove;

- (NSInteger)matchCard:(Card *)card inCards:(NSArray *)currentCards;

@end

@interface PlayingCardMatcher : NSObject <CardMatcher>

@property (nonatomic, strong) NSMutableArray *otherCardsInPlay;
@property BOOL consideredAMove;

- (NSInteger)matchCard:(Card *)card inCards:(NSArray *)currentCards;

@end
