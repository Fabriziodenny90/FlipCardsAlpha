//
//  TestViewController.m
//  FlipCardsAlpha
//
//  Created by Fabrizio Demaria on 05/10/13.
//  Copyright (c) 2013 Fabrizio Demaria. All rights reserved.
//

#import "TestViewController.h"
#import "CardsLibrary.h"
#import "CardView.h"


@interface TestViewController ()
@property (weak, nonatomic) IBOutlet CardView *myCardView;
@property (strong,nonatomic) SinglePlayerRandomCardsGame *myGame;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation TestViewController

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
	// Do any additional setup after loading the view.
    self.myGame = [[SinglePlayerRandomCardsGame alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawButton:(UIButton *)sender {

    Card *randomCard = [self.myGame.redPlayer.deck drawRandomCard];
    if (randomCard){
    self.myLabel.text = [randomCard.idNumber stringValue];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:[[NSString alloc]initWithFormat:@"Card%@Red", [randomCard.idNumber stringValue]] ofType:@"png"];
    self.myCardView.image = [UIImage imageWithContentsOfFile:path1];
    self.myCardView.alpha = 0.0;
    [UIView animateWithDuration:0.3
                         animations:^{ self.myCardView.alpha = 1.0; }
                         completion:nil];
    } else {
        [sender setEnabled:NO];
    }
    
}
@end
