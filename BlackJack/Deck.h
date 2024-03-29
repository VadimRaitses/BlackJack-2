//
//  Deck.h
//  BlackJack
//
//  Created by Vadim raitses on 6/4/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;
- (NSUInteger)cardsCount;
@end
