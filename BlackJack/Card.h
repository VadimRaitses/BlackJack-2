//
//  Card.h
//  BlackJack
//
//  Created by Vadim raitses on 6/4/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, readonly, getter = isAceCard) BOOL aceCard;
@property (nonatomic) NSUInteger cardValue;

//- (int)calculate:(Card *)otherCard;
- (int)calculate:(NSArray *)otherCards;
@end
