//
//  PlayingCardMatcher.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/7/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "PlayingCardMatcher.h"

@implementation PlayingCardMatcher


- (NSInteger)matchCard:(Card *)card inCards:(NSArray *)currentCards {
    int matchScore = 0;
    self.consideredAMove = false;
    self.otherCardsInPlay = [[NSMutableArray alloc] init];
    for (Card *otherCard in currentCards) {
        if (otherCard.faceUp && !otherCard.unplayable) {
            [self.otherCardsInPlay addObject:otherCard];
            matchScore = [card match:@[otherCard]];
            self.consideredAMove = true;
        }
    }
    return matchScore;
}

@end
