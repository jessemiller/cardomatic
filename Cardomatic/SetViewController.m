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

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation SetViewController

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}

- (IBAction)deal {
    self.game = nil;
    [self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetDeck alloc] init] usingMatcher:[[SetCardMatcher alloc] init]];
    return _game;
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
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
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.statusLabel.attributedText = self.game.lastStatus;
    }
}


@end
