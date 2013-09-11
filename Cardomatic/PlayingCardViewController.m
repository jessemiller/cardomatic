//
//  PlayingCardViewController.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/8/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)getDeck {
    return [[PlayingCardDeck alloc] init];
}

- (id <CardMatcher>)getMatcher {
    return [[PlayingCardMatcher alloc] init];
}

- (void)updateCardButton:(UIButton *)cardButton with:(Card *)card {
    [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected];
    [cardButton setAttributedTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
    cardButton.selected = card.faceUp;
    cardButton.enabled = !card.unplayable;
    cardButton.alpha = card.unplayable ? 0.3 : 1.0;
}

@end
