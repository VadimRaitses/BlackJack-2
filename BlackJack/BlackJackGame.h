//
//  NSObject+BlackJackGame.h
//  HomeAssignment
//
//  Created by Vadim Raitses on 8/2/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlackJackCard.h"
@interface BlackJackGame:NSObject

@property (nonatomic, readonly) NSUInteger playerScore;
@property (nonatomic, readonly) NSUInteger dealerScore;


-(instancetype) initWithDeckCount:(NSUInteger)count;
-(Card*) hitCard:(NSMutableArray*)cardStack isDealer:(BOOL)isDealer;
-(void) newGame;
-(void) resetGame:(int)count;

@end
