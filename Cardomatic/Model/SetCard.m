//
//  SetCard.m
//  Cardomatic
//
//  Created by Jesse Miller on 9/4/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validShapes {
    return @[@"●", @"■", @"▲"];
}

+ (NSArray *)validColors {
    return @[[UIColor redColor], [UIColor purpleColor], [UIColor greenColor]];
}

+ (NSArray *)validShading {
    return @[@"solid", @"striped", @"outlined"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

@end
