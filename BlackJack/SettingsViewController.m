//
//  UIViewController+SettingsViewController.m
//  BlackJack
//
//  Created by Vadim Raitses on 8/17/14.
//  Copyright (c) 2014 Vadim Raitses. All rights reserved.
//

#import "SettingsViewController.h"
#include <stdio.h>
static int DECKS_AMOUNT = 1;
static NSString *PLAYER_NAME =@"Player Name";


@interface SettingsViewController()
@property (weak, nonatomic) IBOutlet UITextField *playerName;
@property (weak, nonatomic) IBOutlet UITextField *deckAmount;

@end

@implementation SettingsViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"awakeFromNib");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Settings";
}

-(BOOL)textFieldSholdReturn:(UITextField*)texField{
    [texField resignFirstResponder];
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Second");
//    if(_playerName.text!=PLAYER_NAME || ![_playerName.text isEqual:@""] || _playerName.text !=nil)
//    {
//        [standartUserdefaults setObject:_playerName.text forKey:@"PLAYER_NAME"];
//    }
//    else
//        [standartUserdefaults setObject:PLAYER_NAME forKey:@"PLAYER_NAME"];
//    
//    NSInteger decks = [_deckAmount.text intValue];
//    if(decks>1)
//        [standartUserdefaults setInteger:decks forKey:@"DECKS_AMOUNT"];
//    else
//        [standartUserdefaults setInteger:DECKS_AMOUNT forKey:@"DECKS_AMOUNT"];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSUserDefaults* standartUserdefaults = [NSUserDefaults standardUserDefaults];
    [standartUserdefaults setObject:_playerName.text forKey:@"PLAYER_NAME"];
    NSInteger decks = [_deckAmount.text intValue];
        if(decks>1)
            [standartUserdefaults setInteger:decks forKey:@"DECKS_AMOUNT"];
        else
            [standartUserdefaults setInteger:DECKS_AMOUNT forKey:@"DECKS_AMOUNT"];

     NSLog(@"The Name %@",_playerName.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
