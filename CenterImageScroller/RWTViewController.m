//
//  ViewController.m
//  CenterImageScroller
//
//  Created by Ronald Hernandez on 10/12/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "RWTViewController.h"

@interface RWTViewController ()<UIScrollViewDelegate>

@property UIScrollView *scrollView;
@property UIImageView *imageView;
@end

@implementation RWTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];

    //set the scrollview to start at the left corner of the image -

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.scrollView.backgroundColor = [UIColor blackColor];

    //make the scroll ivew the size of the entire image.

    self.scrollView.contentSize = self.imageView.bounds.size;

    //add the scrollview to the superview

    [self.view addSubview:self.scrollView];


    //add imageview to scrollview

    [self.scrollView addSubview:self.imageView];


    //set scales for zooming

    self.scrollView.delegate = self;

    [self setZoomScale];




}
-(void)viewWillLayoutSubviews{
    [self setZoomScale];
}
-(void)setZoomScale{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;

    CGFloat xScale = boundsSize.width/imageSize.width;
    CGFloat yScale = boundsSize.height/imageSize.height;

    CGFloat minScale = MIN(xScale, yScale);

    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.zoomScale = minScale;
    self.scrollView.maximumZoomScale = 3.0;
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    //


    return self.imageView;
}

@end
