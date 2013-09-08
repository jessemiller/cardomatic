//
//  SetCardMatcher.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/8/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetCardMatcher.h"

@implementation SetCardMatcher

- (NSInteger)matchCard:(Card *)card inCards:(NSArray *)currentCards {
    int matchScore = 0;
    self.consideredAMove = false;
    self.otherCardsInPlay = [[NSMutableArray alloc] init];
    for (Card *otherCard in currentCards) {
        if (otherCard.faceUp && !otherCard.unplayable) {
            for (Card *thirdCard in currentCards) {
                if (thirdCard.faceUp && !thirdCard.unplayable && !(thirdCard == otherCard)) {
                    self.otherCardsInPlay = [[NSMutableArray alloc] initWithArray:@[otherCard, thirdCard]];
                    matchScore = [card match:@[otherCard, thirdCard]];
                    self.consideredAMove = true;
                    break;
                }
            }
        }
    }
    return matchScore;
}

@end
