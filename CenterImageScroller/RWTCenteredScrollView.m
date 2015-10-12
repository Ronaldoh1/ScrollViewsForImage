//
//  RWTCenteredScrollView.m
//  CenterImageScroller
//
//  Created by Ronald Hernandez on 10/12/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "RWTCenteredScrollView.h"

@implementation RWTCenteredScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    [self centerContent];
}
-(void)centerContent{

    UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];

    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = viewToCenter.frame;

    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x =(boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }

    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }

    viewToCenter.frame = frameToCenter;
}

@end
