//
//  ViewController.m
//  CenterImageScroller
//
//  Created by Ronald Hernandez on 10/12/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "RWTViewController.h"

@interface RWTViewController ()
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

}



@end
