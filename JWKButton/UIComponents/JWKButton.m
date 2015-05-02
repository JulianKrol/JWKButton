//
//  JWKButton.m
//  JWKButton
//
//  Created by Julian Król on 02/05/15.
//  Copyright (c) 2015 Julian Król. All rights reserved.
//

#import "JWKButton.h"

@implementation JWKButton

#pragma mark - Overridden

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Public Instance Methods

#pragma mark - Private Instance Methods

- (void)setup
{
    [self setupTitleLabel];
    [self setupConstraints];
}

- (void)setupTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_titleLabel];
}

- (void)setupConstraints
{
    NSDictionary * viewsDictionary = NSDictionaryOfVariableBindings(_titleLabel);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
}

@end
