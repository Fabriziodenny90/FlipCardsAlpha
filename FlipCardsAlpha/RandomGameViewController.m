//
//  RandomGameViewController.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 06/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "RandomGameViewController.h"
#import "SinglePlayerRandomCardsGame.h"
#import "TableCollectionView.h"
#import "HandCollectionView.h"
#import "CPUBrain.h"
#import "MyLayout.h"
#import "MyLayoutTable.h"
#import "RandomGameViewControllerCollectionCardCell.h"

@interface RandomGameViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *CPUPlayesB;
@property (strong, nonatomic) SinglePlayerRandomCardsGame *myGameModel;
@property (nonatomic) BOOL playerHasSelectedCardFromHand;
@property (nonatomic) BOOL playerHasInsertedIntoTable;
@property (nonatomic) BOOL playersTurn;
@property (weak, nonatomic) IBOutlet HandCollectionView *handCollectionView;
@property (weak, nonatomic) IBOutlet TableCollectionView *tableCollectionView;
@property (nonatomic) Card *selectedCardFromHand;
@property (nonatomic) int locationOfSelectedCardInHand;
@property (strong, nonatomic) NSIndexPath *cardFromHandIP;
@property (weak, nonatomic) IBOutlet UILabel *displayedText;

@end

@implementation RandomGameViewController

#define LOCATIONS_ON_TABLE 16

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myGameModel = [[SinglePlayerRandomCardsGame alloc] init];
    _playerHasInsertedIntoTable=YES;
    _playersTurn=YES;
    
    //////////////////
    [self.handCollectionView setCollectionViewLayout:[[MyLayout alloc]initWithNum:[self.myGameModel.redPlayer.hand count]]];
    [self.tableCollectionView setCollectionViewLayout:[[MyLayoutTable alloc]initWithNum:LOCATIONS_ON_TABLE]];
    /////////////////
}

-(int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if([collectionView isMemberOfClass:[HandCollectionView class]]){
        return [self.myGameModel.redPlayer.hand count];
    } else if ([collectionView isMemberOfClass:[TableCollectionView class]]) {
        return LOCATIONS_ON_TABLE;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView isMemberOfClass:[HandCollectionView class]]){
        RandomGameViewControllerCollectionCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
        [cell.myCardView setCardView:self.myGameModel.redPlayer.hand[indexPath.item] isRed:YES] ;
        if(self.playerHasSelectedCardFromHand){
            if (self.locationOfSelectedCardInHand==indexPath.item) {
                [cell.myCardView setSelected];
            }
        }
        return cell;
    } else if ([collectionView isMemberOfClass:[TableCollectionView class]]){
        RandomGameViewControllerCollectionCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
        if([self.myGameModel.cardsOnTable[indexPath.item] isKindOfClass:[Card class]]){
            [cell.myCardView setCardView:self.myGameModel.cardsOnTable[indexPath.item] isRed:[self.myGameModel.colorsOnTable[indexPath.item] isEqualToString:@"Red"]];
        } else [cell.myCardView setTemplate];
        return cell;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if([collectionView isMemberOfClass:[HandCollectionView class]] && self.playerHasInsertedIntoTable==YES && self.playersTurn==YES){
        self.selectedCardFromHand = self.myGameModel.redPlayer.hand[indexPath.item];
        
        //////////
        self.cardFromHandIP = indexPath;
        /////////
        
        self.locationOfSelectedCardInHand=indexPath.item;
        self.playerHasSelectedCardFromHand=YES;
        [collectionView reloadData];
    }
    
    
    
    if([collectionView isMemberOfClass:[TableCollectionView class]] && self.playerHasSelectedCardFromHand==YES){
        
     //   [self.tableCollectionView reloadData];
        BOOL didAdd=[self.myGameModel addCard:self.locationOfSelectedCardInHand atPositionOnTable:@(indexPath.item) byPlayer:self.myGameModel.redPlayer];
        if(didAdd == YES){
            
            ////////////////////////
            MyLayout *handLayout = (MyLayout *)self.handCollectionView.collectionViewLayout;
            handLayout.cellNum--;
            [self.handCollectionView performBatchUpdates:^{
                [self.handCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:self.cardFromHandIP]];
            }
            completion:nil];
            ///////////////////////
            
            RandomGameViewControllerCollectionCardCell *cell=(RandomGameViewControllerCollectionCardCell *)[collectionView cellForItemAtIndexPath:indexPath];
            CGPoint myCenter = [cell center];
            NSMutableArray *myUpdatesIndeces = [[NSMutableArray alloc]init];
            [myUpdatesIndeces addObject:indexPath];
            self.updatingCell = indexPath;
            MyLayoutTable *myLT = (MyLayoutTable *)[self.tableCollectionView collectionViewLayout];
            myLT.updatingCell = indexPath;
            CGPoint leftPoint = myCenter;
            leftPoint.x -= cell.frame.size.width;
            RandomGameViewControllerCollectionCardCell *leftcell=(RandomGameViewControllerCollectionCardCell *)[collectionView cellForItemAtIndexPath:[collectionView indexPathForItemAtPoint:leftPoint]];

            if([collectionView indexPathForItemAtPoint:leftPoint])
                [myUpdatesIndeces addObject:[collectionView indexPathForItemAtPoint:leftPoint]];
            CGPoint belowPoint = myCenter;
            belowPoint.y += cell.frame.size.height;
            RandomGameViewControllerCollectionCardCell *belowCell=(RandomGameViewControllerCollectionCardCell *)[collectionView cellForItemAtIndexPath:[collectionView indexPathForItemAtPoint:belowPoint]];

            if([collectionView indexPathForItemAtPoint:belowPoint])
                [myUpdatesIndeces addObject:[collectionView indexPathForItemAtPoint:belowPoint]];
            CGPoint abovePoint = myCenter;
            abovePoint.y -= cell.frame.size.height;
            RandomGameViewControllerCollectionCardCell *aboveCell=(RandomGameViewControllerCollectionCardCell *)[collectionView cellForItemAtIndexPath:[collectionView indexPathForItemAtPoint:abovePoint]];

            if([collectionView indexPathForItemAtPoint:abovePoint])
                [myUpdatesIndeces addObject:[collectionView indexPathForItemAtPoint:abovePoint]];
            CGPoint rightPoint = myCenter;
            rightPoint.x += cell.frame.size.width;
            RandomGameViewControllerCollectionCardCell *rightCell=(RandomGameViewControllerCollectionCardCell *)[collectionView cellForItemAtIndexPath:[collectionView indexPathForItemAtPoint:rightPoint]];

            if([collectionView indexPathForItemAtPoint:rightPoint])
                [myUpdatesIndeces addObject:[collectionView indexPathForItemAtPoint:rightPoint]];
            
            [self.tableCollectionView performBatchUpdates:^{
                [self.tableCollectionView reloadItemsAtIndexPaths:myUpdatesIndeces];
            } completion:nil];
            
            self.playerHasInsertedIntoTable=YES;
            self.playerHasSelectedCardFromHand=NO;
            self.playersTurn=NO;
            self.CPUPlayesB.enabled = YES;
            [self checkIfSomeoneWon];
        }
        
    }
    
    
}

-(void)CPUPlayes
{
//    NSLog(@"CPU is thinking");
//    NSMutableArray *availableInTable = [[NSMutableArray alloc] init];
//    int i = 0;
//    for(id element in self.myGameModel.cardsOnTable){
//        if ([element isKindOfClass:[NSString class]]){
//            [availableInTable addObject:[[NSNumber alloc] initWithInt:i]];
//        } i++;
//    }
//    
//    int casualCard = (arc4random()%[self.myGameModel.bluePlayer.hand count]);
//    NSNumber *casualLocation = @((arc4random()%[availableInTable count]));
//    BOOL CPUadded = [self.myGameModel addCard:casualCard atPositionOnTable:availableInTable[[casualLocation intValue]] byPlayer:self.myGameModel.bluePlayer];
//    if(!CPUadded) NSLog(@"Couldn't add");
    
    NSDictionary *move = [[CPUBrain class] generateMoveWithModel:self.myGameModel byPlayer:self.myGameModel.bluePlayer];
    int position = [[move objectForKey:@"Position"] intValue];
    int cardInHand = [[move objectForKey:@"CardInHand"] intValue];
    [self.myGameModel addCard:cardInHand atPositionOnTable:@(position) byPlayer:self.myGameModel.bluePlayer];
    return;
}

- (IBAction)CPuPlayRequest:(UIButton *)sender {
    if(self.playersTurn==NO){
        [self CPUPlayes];
        self.playersTurn=YES;
        sender.enabled = NO;
        [self.tableCollectionView reloadData];
        [self checkIfSomeoneWon];
     }
}

-(void)checkIfSomeoneWon
{
    if (![self.myGameModel.cardsOnTable containsObject:@"Empty"]) {
        NSString *winningPlayerId = [self.myGameModel checkWinningId];
        if (![winningPlayerId isEqualToString:@"Tie"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Winner Player" message:winningPlayerId delegate:nil cancelButtonTitle:@"Nice" otherButtonTitles:nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End" message:@"Tie" delegate:nil cancelButtonTitle:@"Nice" otherButtonTitles:nil];
            [alert show];
        }
    }
}



@end
