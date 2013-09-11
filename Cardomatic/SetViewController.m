//
//  SetViewController.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/4/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetViewController.h"
#import "CardMatchingGame.h"
#import "SetDeck.h"
#import "SetCardMatcher.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (Deck *)getDeck {
    return [[SetDeck alloc] init];
}

- (id <CardMatcher>)getMatcher {
    return [[SetCardMatcher alloc] init];
}

- (void)updateCardButton:(UIButton *)cardButton with:(Card *)card {
    [cardButton setAttributedTitle:card.contents forState:UIControlStateNormal];
    [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected];
    [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.selected = card.faceUp;
    if (card.faceUp) {
        cardButton.backgroundColor = [UIColor blackColor];
    } else {
        cardButton.backgroundColor = [UIColor whiteColor];
    }
    cardButton.enabled = !card.unplayable;
    cardButton.alpha = card.unplayable ? 0.3 : 1.0;
}

@end
