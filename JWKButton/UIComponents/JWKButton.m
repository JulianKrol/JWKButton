//
//  JWKButton.m
//  JWKButton
//
//  Created by Julian Król on 02/05/15.
//  Copyright (c) 2015 Julian Król. All rights reserved.
//

#import "JWKButton.h"

@interface JWKButton ()

@property(strong, nonatomic) NSMutableDictionary * configurationsDictionary;

@end

static NSString * const titleKey = @"JWKButton.titleKey";
static NSString * const titleColorKey = @"JWKButton.titleColorKey";

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

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSString * configurationDictionaryKey = [NSString stringWithFormat:@"%d", state];
    NSMutableDictionary * configurationDictionary = self.configurationsDictionary[configurationDictionaryKey];
    if (!configurationDictionary) {
        configurationDictionary = [[NSMutableDictionary alloc] init];
        self.configurationsDictionary[configurationDictionaryKey] = configurationDictionary;
    }
    configurationDictionary[titleKey] = title;
    [self updateUI];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self updateUI];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self updateUI];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self updateUI];
}

#pragma mark - Private Instance Methods

- (void)setup
{
    _configurationsDictionary = [[NSMutableDictionary alloc] init];
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
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
}

- (void)updateUI
{
    NSString * stateStringKey = [NSString stringWithFormat:@"%d", self.state];
    NSDictionary * configurationDictionary = self.configurationsDictionary[stateStringKey];
    if (configurationDictionary) {
        self.titleLabel.text = configurationDictionary[titleKey] ? : @"";
        self.titleLabel.textColor = configurationDictionary[titleColorKey] ? : [UIColor whiteColor];
    }
}

@end
