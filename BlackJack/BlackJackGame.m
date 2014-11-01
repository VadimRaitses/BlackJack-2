//
//  NSObject+BlackJackGame.m
//  HomeAssignment
//
//  Created by Vadim Raitses on 8/2/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "BlackJackGame.h"
#import "BlackJackGameViewController.h"
#import "BlackJackDeck.h"
#import "BlackJackCard.h"
@interface BlackJackGame()

@property (nonatomic,readwrite)NSUInteger dealerScore;
@property (nonatomic,readwrite)NSUInteger playerScore;
@property (nonatomic,readwrite)NSUInteger deckIndex;
@property (strong,nonatomic)NSMutableArray* decks;

@end

@implementation BlackJackGame

-(NSMutableArray*)decks{
    if(!_decks){
        _decks =[[NSMutableArray alloc]init];
    }
    return _decks;
}
-(instancetype) initWithDeckCount:(NSUInteger)count{
    self = [super init];
    if(self){
    [self resetGame:count];
    }
    return self;
}

-(Card*) hitCard:(NSMutableArray*)cardStack isDealer:(BOOL)isDealer{
     NSUInteger handscore=0;
   Card *card = [self.decks[self.deckIndex] drawRandomCard];
    while (self.deckIndex<self.decks.count){
        
        [cardStack addObject:card];
      		
        if(card!=nil){
            for(NSInteger i= 0; i<cardStack.count;i++)
            handscore = [card calculate:cardStack];
                        if(isDealer){
                self.dealerScore=handscore;
                return card;
            }
            else{
                self.playerScore=handscore;
                return card;
            }
        }
        
        else{
            self.deckIndex+=1;
        }
    }
    if([self.decks[self.deckIndex] count]==0){
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"Game Over"
         object:self];
    }
    
    
    return card;
}
-(void) newGame{
    self.dealerScore=0;
    self.playerScore=0;
    
}
-(void) resetGame:(int)count{
    
    [self newGame];
    self.deckIndex=0;
    self.decks = nil;
    for (NSInteger i=0; i<count;i++) {
        BlackJackDeck *deck  =[[BlackJackDeck alloc]init];
        [self.decks addObject:deck];
   }
    
}



@end
