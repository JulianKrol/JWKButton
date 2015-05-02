//
//  ViewController.m
//  JWKButton
//
//  Created by Julian on 02/05/15.
//  Copyright (c) 2015 Julian Król. All rights reserved.
//


#import "ViewController.h"
#import "JWKButton.h"


@interface ViewController ()

@end

@implementation ViewController


#pragma mark - Overridden

- (void)viewDidLoad
{
    [super viewDidLoad];

    JWKButton * improvedButton = [[JWKButton alloc] init];
    improvedButton.backgroundColor = [UIColor redColor];
    improvedButton.titleLabel.numberOfLines = 0;
    improvedButton.titleLabel.preferredMaxLayoutWidth = 40;
    improvedButton.titleLabel.text = [self buttonTitle];
    improvedButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:improvedButton];

    UIButton * standardButton = [[UIButton alloc] init];
    standardButton.backgroundColor = [UIColor redColor];
    standardButton.titleLabel.numberOfLines = 0;
    standardButton.titleLabel.preferredMaxLayoutWidth = 40;
    [standardButton setTitle:[self buttonTitle] forState:UIControlStateNormal];
    standardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:standardButton];

    NSDictionary * viewsDictionary = NSDictionaryOfVariableBindings(improvedButton, standardButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[improvedButton]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[improvedButton]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[standardButton]-20-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[standardButton]-20-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
}

#pragma mark - Private Instance Methods

- (NSString *)buttonTitle
{
    return @"This is my long enough title";
}

@end
