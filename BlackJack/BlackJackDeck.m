//
//  BlackJackDeck.m
//  BlackJack
//
//  Created by Vadim raitses on 6/4/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "BlackJackDeck.h"
#import "BlackJackCard.h"

@implementation BlackJackDeck

- (instancetype) init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [BlackJackCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [BlackJackCard maxRank]; rank++) {
                BlackJackCard *card = [[BlackJackCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                card.cardValue = rank;
                [self addCard:card];
            }
        }
    }
    
    return self;
}
@end
