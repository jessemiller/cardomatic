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
#import "PlayingCardCollectionViewCell.h"

@interface CardomaticViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@end

@implementation CardomaticViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.game cardsInPlay];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.cardCollectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (Deck *)getDeck {
    // abstract
    return nil;
}

- (id <CardMatcher>)getMatcher {
    // abstract
    return nil;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    // abstract
}
- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        [self updateUI];
    }
}

- (IBAction)deal {
    self.game = nil;
    [self updateUI];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:20 usingDeck:[self getDeck] usingMatcher:[self getMatcher]];
    return _game;
}

- (void)updateUI {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusLabel.attributedText = self.game.lastStatus;
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
}

@end
