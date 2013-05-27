//
//  happinessViewController.m
//  happiness
//
//  Created by david on 13-5-23.
//  Copyright (c) 2013年 david. All rights reserved.
//

#import "happinessViewController.h"
#import "faceView.h"

@interface happinessViewController ()<FaceViewDataSource>
@property (weak, nonatomic) IBOutlet faceView *faceView;
@end

@implementation happinessViewController


@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

-(void) setFaceView:(faceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}

-(void) handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

-(float) smileForFaceView:(faceView *)sender
{
    return  (self.happiness - 50.0) / 50.0;
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

@end
