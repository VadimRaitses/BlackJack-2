//
//  Card.m
//  BlackJack
//
//  Created by Vadim raitses on 6/4/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.//

#import "Card.h"

@interface Card()
@property (nonatomic, readwrite, getter = isAceCard) BOOL aceCard;
@end

@implementation Card
@synthesize aceCard = _aceCard;
@synthesize contents = _contents;
@synthesize cardValue = _cardValue;

- (NSString *)contents
{
	return _contents;
}
- (void)setContents:(NSString *)contents
{
	_contents = contents;
}

- (BOOL) isAceCard {
    return _aceCard;
}
- (void) setAceCard:(BOOL)aceCard {
    _aceCard = aceCard;
}

- (NSUInteger)cardValue
{
	return _cardValue;
}
- (void) setCardValue:(NSUInteger)cardValue
{
	_cardValue = cardValue <= 10 ? cardValue : 10;
    if (_cardValue == 1) { [self setAceCard:true]; }
}

/*- (int)calculate:(Card *)otherCard {
    if ([otherCard.contents isEqualToString:self.contents]) {
        return self.cardValue + otherCard.cardValue;
    }
    return 0;
}*/

- (int)calculate:(NSArray *)otherCards
{
    int score = self.cardValue;
    
    //iterate through otherCards
    for (Card *card in otherCards) {
        
        //calc values
        score += card.cardValue;
    }
    
    return score;
}

@end
