//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by david on 13-5-26.
//  Copyright (c) 2013年 david. All rights reserved.
//

#import "PsychologistViewController.h"
#import "happinessViewController.h"

@interface PsychologistViewController ()

@property (nonatomic) int diagnosis;

@end

@implementation PsychologistViewController

@synthesize diagnosis = _diagnosis;

-(void) setAndShowDiagnosis:(int)diagnosis
{
    self.diagnosis = diagnosis;
    [self performSegueWithIdentifier:@"showDiagnosis" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDiagnosis"])
    {
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
    else if([segue.identifier isEqualToString:@"movie"])
    {
        [segue.destinationViewController setHappiness:50];
    }
    else if([segue.identifier isEqualToString:@"teleplay"])
    {
        [segue.destinationViewController setHappiness:20];
    }
    else if([segue.identifier isEqualToString:@"cartoon"])
    {
        [segue.destinationViewController setHappiness:100];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (IBAction)flaying:(id)sender
{
    [self setAndShowDiagnosis:86];
}

- (IBAction)bite:(id)sender
{
    [self setAndShowDiagnosis:70];
}

- (IBAction)play:(id)sender
{
    [self setAndShowDiagnosis:20];
}
@end
