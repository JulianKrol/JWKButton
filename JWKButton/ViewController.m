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

@property(strong, nonatomic) JWKButton * improvedButton;
@property(strong, nonatomic) UIButton * standardButton;

@end

@implementation ViewController


#pragma mark - Overridden

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.improvedButton = [[JWKButton alloc] init];
    self.improvedButton.backgroundColor = [UIColor redColor];
    self.improvedButton.titleLabel.numberOfLines = 0;
//    self.improvedButton.titleLabel.preferredMaxLayoutWidth = 40;
    [self.improvedButton setTitle: [self buttonTitle]forState:UIControlStateNormal];
    self.improvedButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.improvedButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.improvedButton];

    self.standardButton = [[UIButton alloc] init];
    self.standardButton.backgroundColor = [UIColor redColor];
    self.standardButton.titleLabel.numberOfLines = 0;
//    self.standardButton.titleLabel.preferredMaxLayoutWidth = 40;
    [self.standardButton setTitle:[self buttonTitle] forState:UIControlStateNormal];
    self.standardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.standardButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.standardButton];

    NSDictionary * viewsDictionary = NSDictionaryOfVariableBindings(_improvedButton, _standardButton);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_improvedButton]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_improvedButton]"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_standardButton]-20-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_standardButton]-20-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.improvedButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [self.improvedButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.improvedButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [self.improvedButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateHighlighted];

    [self.standardButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [self.standardButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.standardButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [self.standardButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateHighlighted];
}

#pragma mark - Actions

- (void)tapped:(UIControl *)tapped
{
    tapped.selected = YES;
}

#pragma mark - Private Instance Methods

- (NSString *)buttonTitle
{
    return @"This is my long enough title";
}

@end
