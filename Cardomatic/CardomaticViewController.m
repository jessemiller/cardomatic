//
//  CardomaticViewController.m
//  Cardomatic
//
//  Created by Jesse Miller on 8/13/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "CardomaticViewController.h"

@interface CardomaticViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cards;

@end

@implementation CardomaticViewController

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

@end
