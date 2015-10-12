//
//  RWTCenteredScrollView.m
//  ImageScroller
//
//  Created by Main Account on 4/21/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTCenteredImageScrollView.h"

@interface RWTCenteredImageScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) BOOL firstTime;
@property (nonatomic, assign) CGSize oldSize;
@property (nonatomic, assign) CGPoint oldCenterPoint;

@property (weak, nonatomic) NSLayoutConstraint *constraintRight;
@property (weak, nonatomic) NSLayoutConstraint *constraintTop;
@property (weak, nonatomic) NSLayoutConstraint *constraintLeft;
@property (weak, nonatomic) NSLayoutConstraint *constraintBottom;

@end

@implementation RWTCenteredImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.imageView];

        self.constraintRight = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        [self addConstraint:self.constraintRight];

        self.constraintTop = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        [self addConstraint:self.constraintTop];

        self.constraintBottom = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [self addConstraint:self.constraintBottom];

        self.constraintLeft = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        [self addConstraint:self.constraintLeft];

        self.delegate = self;
        self.firstTime = YES;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];

    }
    return self;
}

- (void)orientationChanged:(id)sender {
    [self setNeedsLayout];
}

- (void)layoutSubviews {

    [super layoutSubviews];

    if (self.firstTime) {
        [self setZoomScales];
    }

    [self centerContent];
    [self layoutIfNeeded];

    if (self.firstTime) {
        self.firstTime = NO;
    } else if (!CGSizeEqualToSize(self.bounds.size, self.oldSize)) {
        [self adjustInnerView];
        self.oldSize = self.bounds.size;
    }

    self.oldCenterPoint = [self centerPoint];
    NSLog(@"Center point: %@", NSStringFromCGPoint(self.oldCenterPoint));

}

- (CGPoint)centerPoint {

    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {

        UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];

        CGPoint scrollViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGPoint imageCenter = [self convertPoint:scrollViewCenter toView:viewToCenter];
        return imageCenter;

    }
    return CGPointZero;

}

- (void)adjustInnerView {

    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {

        UIView *innerView = [self.delegate viewForZoomingInScrollView:self];

        CGPoint desiredCenter = [innerView convertPoint:self.oldCenterPoint toView:self];
        CGPoint actualCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

        CGPoint contentOffset = [self contentOffset];
        contentOffset.x += desiredCenter.x - actualCenter.x;
        contentOffset.y += desiredCenter.y - actualCenter.y;
        self.contentOffset = contentOffset;

    }
}

- (void)centerContent {

    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {

        UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];

        // center the view as it becomes smaller than the size of the screen
        CGSize boundsSize = self.bounds.size;
        CGRect frameToCenter = viewToCenter.frame;

        // center horizontally
        if (frameToCenter.size.width < boundsSize.width) {
            CGFloat padding = (boundsSize.width - frameToCenter.size.width) / 2;
            self.constraintLeft.constant = padding;
            self.constraintRight.constant = padding;
        } else {
            self.constraintLeft.constant = 0;
            self.constraintRight.constant = 0;
        }

        // center vertically
        if (frameToCenter.size.height < boundsSize.height) {
            CGFloat padding = (boundsSize.height - frameToCenter.size.height) / 2;
            self.constraintTop.constant = padding;
            self.constraintBottom.constant = padding;
        } else {
            self.constraintTop.constant = 0;
            self.constraintBottom.constant = 0;
        }

    }
}

- (void)setZoomScales {

    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {

        UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];

        CGSize boundsSize = self.bounds.size;
        CGSize contentSize = viewToCenter.bounds.size;

        CGFloat xScale = boundsSize.width / contentSize.width; // the scale needed to perfectly fit the image width-wise
        CGFloat yScale = boundsSize.height / contentSize.height; // the scale needed to perfectly fit the iamge height-wise
        CGFloat minScale = MIN(xScale, yScale);
        
        self.minimumZoomScale = minScale;
        self.zoomScale = minScale;
        self.maximumZoomScale = 3.0;
        
    }
    
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
