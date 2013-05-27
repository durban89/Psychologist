//
//  faceView.h
//  happiness
//
//  Created by david on 13-5-23.
//  Copyright (c) 2013年 david. All rights reserved.
//

#import <UIKit/UIKit.h>


@class faceView;

@protocol FaceViewDataSource
-(float) smileForFaceView:(faceView *) sender;
@end


@interface faceView : UIView

@property (nonatomic) CGFloat scale;
-(void) pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id<FaceViewDataSource> dataSource;

@end
