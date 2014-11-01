//
//  BlackJackGameViewController.m
//  BlackJack
//
//  Created by Vadim Raitses on 8/17/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "BlackJackGameViewController.h"
#import "SettingsViewController.h"
#import "BlackJackDeck.h"
#import "BlackJackGame.h"
#import "BlackJackCard.h"
#import "CardView.h"
#include <stdio.h>

static int DECK_COUNT = 1;
static NSString *PLAYER_NAME =@"Player Name";
@interface BlackJackGameViewController ()
@property (nonatomic, strong) BlackJackGame *game;
@property (weak, nonatomic) IBOutlet UILabel *dealerScore;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;

@property (weak, nonatomic) IBOutlet UILabel *gameMessage;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gotoSettings;

@property (weak, nonatomic) IBOutlet CardView *HitSwiper;

@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *dealerCardViews;
@property (strong, nonatomic) IBOutletCollection(CardView) NSArray *playerCardViews;
@property (nonatomic, strong) NSMutableArray* playerCardStack;
@property (nonatomic, strong) NSMutableArray* dealerCardStack;
@property (weak, nonatomic) IBOutlet UILabel *userName;


- (void) restartMatch;
- (void) playDealer;
- (void) updateUI:(BOOL)isPlayer;
- (void) A;
@end

@implementation BlackJackGameViewController






- (void) dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
  
}



- (void) receiveNotification:(NSNotification *) notification
{
    
    
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SHUFFLE?"
                                            message:@"All card in deck is over"
                                            delegate:self
                                            cancelButtonTitle:@"Shuffle"
                                            otherButtonTitles:nil];
[alert show];

                          
}
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
 [self restartMatch];
    
}

- (BlackJackGame *)game {
    if (!_game) _game = [[BlackJackGame alloc] initWithDeckCount:DECK_COUNT];
    return _game;
}

- (NSMutableArray *)playerCardStack {

    if(_playerCardStack==nil){
    _playerCardStack = [[NSMutableArray alloc]init];
    }
    return  _playerCardStack;

}

- (NSMutableArray *)dealerCardStack {

    if(_dealerCardStack==nil){
        _dealerCardStack = [[NSMutableArray alloc]init];
    }
    return _dealerCardStack;
}

- (void)viewDidLoad
{
    id myobject;
    myobject=[[NSString alloc] init];
    myobject=@"aaa";
    
    [super viewDidLoad];
    [self.game newGame];
    [self restartMatch];
    //TODO: Write logic
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"Game Over"
                                                 object:nil];
    
    NSLog(@"First");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSInteger decks = 0;
    [ud setInteger:decks forKey:@"DECKS_AMOUNT"];
    if(decks>1)
    DECK_COUNT=decks;
    PLAYER_NAME = [ud stringForKey:@"PLAYER_NAME"];
    NSLog(@"%@",PLAYER_NAME);
    
    if(PLAYER_NAME.length>0)
    {
        
        self.userName.text = [NSString stringWithFormat:@"%@ Score %d",PLAYER_NAME, [self.game playerScore]];

    }
     else{
        PLAYER_NAME=@"Player_Name";
      //  self.userName.text = [NSString stringWithFormat:@"%@ score",@"Player Name"];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:@"Game Over"
                                                 object:nil];
}


- (void) restartMatch
{
    for(NSInteger i = 0;i<[self.dealerCardViews count];i++){
        CardView *cardView = self.dealerCardViews[i];
        cardView.hidden = true;
        cardView.faceUp =false;

    }
    for(NSInteger i = 0;i<[self.playerCardViews count];i++){
        CardView *cardView = self.playerCardViews[i];
        cardView.hidden = true;
        cardView.faceUp =false;
        
    }
   
   // self.game=nil;
    self.playerCardStack=nil;
    self.dealerCardStack=nil;
    self.dealerScore.text=@"Dealer Score: ";
 //      self.playerScore.text=[NSString stringWithFormat:@"%@ score:",PLAYER_NAME];
    self.gameMessage.text=@"";
    self.standButton.enabled = true;
    [self.standButton setTitle:@"Stand" forState:UIControlStateNormal];
    
    [self.game hitCard:self.dealerCardStack isDealer:true];
    CardView *cardView = self.dealerCardViews[1];
    cardView.hidden = false;
    cardView.faceUp =false;
    BlackJackCard *card =   (BlackJackCard*)[self.game hitCard:self.playerCardStack isDealer:false];
    self.HitSwiper.suit = card.suit;
    self.HitSwiper.rank = card.rank;
  //  NSLog([NSString stringWithFormat:@"%d",[self.game playerScore]]);
    self.playerScore.text = [NSString stringWithFormat:@"%@ Score: %d",PLAYER_NAME, [self.game playerScore]];
    self.dealerScore.text = [NSString stringWithFormat:@"Dealer Score: %d", [self.game dealerScore]];
    [self updateUI:true];
 
}

- (void) playDealer {
    while (self.game.dealerScore<=DEALER_MIN_HAND_VALUE) {
        
        [self.game hitCard:self.dealerCardStack isDealer:true];
        [self updateUI:true];
    }
}

- (void) updateUI:(BOOL)isPlayer {
    if (self.dealerCardStack) {
        for (int i = 0; i < [self.dealerCardStack count]; i++) {
            if (i < [self.dealerCardViews count]) {
                BlackJackCard *card = self.dealerCardStack[i];
                CardView *cardView = self.dealerCardViews[i];
                
                cardView.hidden = false;
                cardView.rank = card.rank;
                cardView.suit =card.suit;
                cardView.faceUp =true;

            }
        }
    }
    if (self.playerCardStack) {
        for (int i = 0; i < [self.playerCardStack count]; i++) {
            if (i < [self.playerCardViews count]) {
                BlackJackCard *card = self.playerCardStack[i];
                CardView *cardView = self.playerCardViews[i];
                cardView.hidden = false;
                cardView.rank = card.rank;
                cardView.suit =card.suit;
                cardView.faceUp =true;
            }
        }
    }
    
    self.playerScore.text = [NSString stringWithFormat:@"%@ Score: %d",PLAYER_NAME, [self.game playerScore]];
    self.dealerScore.text = [NSString stringWithFormat:@"Dealer Score: %d", [self.game dealerScore]];
    
    if ([self.game playerScore] > BLACK_JACK) {
        if ([self.game dealerScore] <= BLACK_JACK) {
            self.gameMessage.text = @"Busted!";
        } else {
            self.gameMessage.text = @"Draw!";
        }
        self.standButton.enabled = true;
        [self.standButton setTitle:@"Rematch" forState:UIControlStateNormal];
        //self.standButton.titleLabel.text = @"Rematch"; <-- not working due to several button states
    }
    else if ([self.game playerScore] == BLACK_JACK) {
        if ([self.game dealerScore] == BLACK_JACK) {
            self.gameMessage.text = @"Draw!";
        }
        else {
            self.gameMessage.text = @"BlackJack!";
        }
        self.standButton.enabled = true;
        [self.standButton setTitle:@"Rematch" forState:UIControlStateNormal];
    }
    else { //playerScore < 21
        if ([self.game dealerScore] > BLACK_JACK) {
            self.gameMessage.text = @"You Win!";
            self.standButton.enabled = true;
            [self.standButton setTitle:@"Rematch" forState:UIControlStateNormal];
        }
        else if ([self.game dealerScore] == BLACK_JACK) {
            self.gameMessage.text = @"You Lost!";
            self.standButton.enabled = true;
            [self.standButton setTitle:@"Rematch" forState:UIControlStateNormal];
        }
        else {
            if (isPlayer) {
                self.gameMessage.text = @"";
                self.standButton.enabled = true;
                [self.standButton setTitle:@"Stand" forState:UIControlStateNormal];
            }
            else {//dealer is playing
                if ([self.game playerScore] < [self.game dealerScore]) {
                    self.gameMessage.text = @"You Lost!";
                }
                else if ([self.game playerScore] == [self.game dealerScore]) {
                    self.gameMessage.text = @"Draw!";
                }
                else {
                    self.gameMessage.text = @"You Win!";
                }
                self.standButton.enabled = true;
                [self.standButton setTitle:@"Rematch" forState:UIControlStateNormal];
            }
        }
    }
}



- (IBAction)swipe1:(id)sender {
    NSLog(@"SWIPE 1");
}

- (IBAction)swipe2:(id)sender {
    NSLog(@"SWIPE 2");
}
- (IBAction)swipe3:(id)sender {
    NSLog(@"SWIPE 3");
     }
- (IBAction)swipe4:(id)sender {
    NSLog(@"SWIPE 4");
}
- (IBAction)swipe5:(id)sender {
    NSLog(@"SWIPE 5");
    [self A];
      }
- (IBAction)swipe6:(id)sender {
    NSLog(@"SWIPE 6");
     [self A];
    
}
- (IBAction)swipe7:(id)sender {
    [self A];
    
}
- (IBAction)swipe8:(id)sender {
    [self A];
   
}

-(void)A{
    CardView *cardView = self.HitSwiper;
    BlackJackCard *card = (BlackJackCard*)[self.game hitCard:_playerCardStack isDealer:NO];
    cardView.suit = card.suit;
    cardView.rank = card.rank;
    [self updateUI:true];
    
    if ([self.game playerScore] >= BLACK_JACK) {
        [self playDealer];
    }
    NSLog(@"The Card!!!");

}

- (IBAction)SwipeCard:(id)sender {
   //

    CardView *cardView = self.HitSwiper;

    cardView.faceUp =true;
    BlackJackCard *card = (BlackJackCard*)[self.game hitCard:_playerCardStack isDealer:NO];
    cardView.suit = card.suit;
    cardView.rank = card.rank;
    [self updateUI:true];
    
    if ([self.game playerScore] >= BLACK_JACK) {
        [self playDealer];
    }
    NSLog(@"The Card!!!");
}

- (IBAction)touchStandButton:(UIButton *)sender {
    if ([self.standButton.titleLabel.text isEqualToString:@"Stand"]) {
        self.standButton.enabled = false;
        [self playDealer];
    }
    else {
        [self restartMatch];
    }
}


- (IBAction)changePage:(id)sender {
    SettingsViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsVC"];
    [self.navigationController pushViewController: settingsViewController animated:YES];
}

@end
