//
//  faceView.m
//  happiness
//
//  Created by david on 13-5-23.
//  Copyright (c) 2013年 david. All rights reserved.
//

#import "faceView.h"

#define DEFAULT_SCALE 0.90
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS  0.10
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25


@implementation faceView

@synthesize scale = _scale;

-(CGFloat) scale
{
    if(!_scale)
    {
        return DEFAULT_SCALE;
    }else{
        return _scale;
    }
}


-(void) setScale:(CGFloat)scale
{
    if(scale != _scale)
    {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

-(void) pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded))
    {
        self.scale = gesture.scale;
        gesture.scale = 1;
    }
}


-(void) setup
{
    self.contentMode = UIViewContentModeRedraw;
}

-(void) awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void) drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0 , 2*M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    //face
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width / 2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height / 2;
    
    
    CGFloat size = self.bounds.size.width / 2;
    if(self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height / 2;
    
    size *= self.scale;
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext: context];
    
    //eye
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];
    eyePoint.x +=  size * EYE_H  * 2;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];
    
    
    //mouth
    CGPoint mouthStartPoint;
    mouthStartPoint.x = midPoint.x - size * MOUTH_H;
    mouthStartPoint.y = midPoint.y + size * MOUTH_V;
    CGPoint mouthEndPoint = mouthStartPoint;
    mouthEndPoint.x += MOUTH_H * size * 2;
    
    CGPoint mouthCP1 = mouthStartPoint;
    mouthCP1.x += MOUTH_H * size * 2 / 3;
    
    CGPoint mouthCP2 = mouthEndPoint;
    mouthCP2.x -= MOUTH_V * size * 2 / 3;
    
    float smile = [self.dataSource smileForFaceView:self];
    if(smile < -1) smile = -1;
    if(smile > 1) smile = 1;
    
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStartPoint.x, mouthStartPoint.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEndPoint.x, mouthEndPoint.y);
    CGContextStrokePath(context);
    
    
    
    
    // Drawing code
}


@end
