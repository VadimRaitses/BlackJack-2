//
//  BlackJackCard.h
//  BlackJack
//
//  Created by Vadim Raitses on 8/17/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.

#import "Card.h"

static const int BLACK_JACK = 21;
static const int ACE_MAX_VALUE = 11;
static const int ACE_MIN_VALUE = 1;
static const int DEALER_MIN_HAND_VALUE = 17;

@interface BlackJackCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end
