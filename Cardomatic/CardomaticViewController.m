//
//  CardomaticViewController.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/13/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "CardomaticViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardomaticViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cards;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation CardomaticViewController

- (Deck *)getDeck {
    // abstract
    return nil;
}

- (id <CardMatcher>)getMatcher {
    // abstract
    return nil;
}

- (void)updateCardButton:(UIButton *)cardButton with:(Card *)card {
    // abstract
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cards indexOfObject:sender]];
    [self updateUI];
}

- (IBAction)deal {
    self.game = nil;
    [self updateUI];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cards.count usingDeck:[self getDeck] usingMatcher:[self getMatcher]];
    return _game;
}

- (void)setCards:(NSArray *)cards {
    _cards = cards;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cards) {
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.statusLabel.attributedText = self.game.lastStatus;
        Card *card = [self.game cardAtIndex:[self.cards indexOfObject:cardButton]];
        [self updateCardButton:cardButton with:card];
    }
}

@end
