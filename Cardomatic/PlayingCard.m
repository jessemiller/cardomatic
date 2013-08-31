//
//  PlayingCard.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/25/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;

    if (otherCards.count == 1) {
        PlayingCard *card = [otherCards lastObject];
        if ([card.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (card.rank == self.rank) {
            score = 4;
        }
    }
    
    return score;
}

- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+ (NSArray *)rankStrings {
    return @[@"A",
             @"2",
             @"3",
             @"4",
             @"5",
             @"6",
             @"7",
             @"8",
             @"9",
             @"10",
             @"J",
             @"Q",
             @"K"];
}

+ (NSArray *)validSuits {
    return @[@"♠", @"♣", @"♥", @"♦"];
}

+ (NSUInteger)maxRank {
    return 12;
}

@end
