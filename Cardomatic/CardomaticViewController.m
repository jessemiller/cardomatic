//
//  CardomaticViewController.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/13/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "CardomaticViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardomaticViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cards;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardomaticViewController

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setCards:(NSArray *)cards {
    _cards = cards;
    for (UIButton *cardButton in cards) {
        Card *card = [self.deck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}

@end
