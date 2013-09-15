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
#import "SetCardCollectionViewCell.h"
#import "SetCardView.h"
#import "SetCard.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (Deck *)getDeck {
    return [[SetDeck alloc] init];
}

- (id <CardMatcher>)getMatcher {
    return [[SetCardMatcher alloc] init];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardCollectionViewCell *pccvc = (SetCardCollectionViewCell *)cell;
        [self updateSetCardView:pccvc.setCardView with:card];
    }
}

- (void)updateSetCardView:(SetCardView *)setCardView with:(Card *)card {
    SetCard *setCard = (SetCard *)card;
    setCardView.color = setCard.color;
    setCardView.shading = setCard.shading;
    setCardView.shape = setCard.shape;
    setCardView.number = setCard.number;
    setCardView.faceUp = setCard.faceUp;
    setCardView.alpha = setCard.unplayable ? 0.3 : 1.0;
}

@end
