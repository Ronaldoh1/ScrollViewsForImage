//
//  ViewController.m
//  CenterImageScroller
//
//  Created by Ronald Hernandez on 10/12/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTCenteredImageScrollView.h"

@interface RWTViewController ()

@property RWTCenteredImageScrollView *scrollView;
@property UIImageView *imageView;
@end

@implementation RWTViewController

- (void)viewDidLoad {

    self.scrollView = [[RWTCenteredImageScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];

    NSDictionary *viewsDictionary = @{@"scrollView": self.scrollView};

    NSArray *horzConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:horzConstraints];

    NSArray *vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:vertConstraints];
}

@end
