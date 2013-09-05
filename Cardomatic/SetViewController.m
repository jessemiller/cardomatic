//
//  SetViewController.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/4/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetViewController

- (IBAction)deal {
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    
}


@end
