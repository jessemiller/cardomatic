//
//  SetCardView.h
//  Cardomatic
//
//  Created by Jesse Miller on 9/14/13.
//  Copyright (c) 2013 Jesse Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView
@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSString *shading;

@property (nonatomic) BOOL faceUp;
@end
