//
//  CardomaticViewController.h
//  Cardomatic
//
//  Created by Jesse Miller on 8/13/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "PlayingCardMatcher.h"
#import "Card.h"

@interface CardomaticViewController : UIViewController

- (Deck *)getDeck;
- (id <CardMatcher>)getMatcher;
- (void)updateCardButton:(UIButton *)cardButton with:(Card *)card;

@end
