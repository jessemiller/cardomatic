//
//  Card.h
//  Cardomatic
//
//  Created by Jesse Miller on 8/25/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
