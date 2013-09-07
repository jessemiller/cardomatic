//
//  SetCard.h
//  Cardomatic
//
//  Created by Jesse Miller on 9/4/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSString *shading;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
+ (NSUInteger)maxNumber;

@end
