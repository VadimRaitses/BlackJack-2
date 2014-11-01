//
//  BlackJackCard.m
//  BlackJack
//
//  Created by Vadim Raitses on 8/17/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "BlackJackCard.h"

@implementation BlackJackCard

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (NSString *)contents
{
    return [[BlackJackCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[BlackJackCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [BlackJackCard maxRank]) {
        _rank = rank;
    }
}

- (int)calculate:(NSArray *)otherCards
{
    int score = 0;
    int aces = 0;
    
    if (self.isAceCard) {
        aces++;
    }
    else {
      //  score = self.cardValue;
    }
    
    //iterate through otherCards
    for (Card *card in otherCards) {
        
        if (card.isAceCard) {
            aces++;
        }
        else {
            //calc values
            score += card.cardValue;
        }
    }
    
    if (aces > 0) {
        for (int i = 0; i < aces; i++) {
            if (score + ACE_MAX_VALUE <= BLACK_JACK) {
                score += ACE_MAX_VALUE;
            }
            else {
                score += ACE_MIN_VALUE;
            }
        }
    }
    
    return score;
}

@end
