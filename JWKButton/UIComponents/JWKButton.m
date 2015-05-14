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
@property(copy, nonatomic) NSArray * modifiableConstraints;

@end

static NSString * const titleKey = @"JWKButton.titleKey";
static NSString * const titleColorKey = @"JWKButton.titleColorKey";
static NSString * const backgroundColorKey = @"JWKButton.backgroundColorKey";
static NSString * const imageKey = @"JWKButton.imageKey";

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

#pragma mark - Public Instance Methods

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSMutableDictionary * configurationDictionary = [self configurationForState:state];
    configurationDictionary[titleKey] = title;
    [self updateUI];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    NSMutableDictionary * configurationDictionary = [self configurationForState:state];
    configurationDictionary[titleColorKey] = color;
    [self updateUI];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    NSMutableDictionary * configurationDictionary = [self configurationForState:state];
    configurationDictionary[imageKey] = image;
    [self updateUI];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    NSMutableDictionary * configurationDictionary = [self configurationForState:state];
    configurationDictionary[backgroundColorKey] = color;
    [self updateUI];
}

- (void)setupConstraintsForSubviews:(NSArray * (^)(UILabel *, UIImageView *))createConstraints
{
    if (!createConstraints) {
        return;
    }
    if (self.modifiableConstraints) { //to prevent iOS 7 crash
        [self removeConstraints:self.modifiableConstraints];
    }
    self.modifiableConstraints = createConstraints(self.titleLabel, self.imageView);
    [self addConstraints:self.modifiableConstraints];
    [self layoutIfNeeded];
}

#pragma mark - Private Instance Methods

- (void)setup
{
    _configurationsDictionary = [[NSMutableDictionary alloc] init];
    [self setupImageView];
    [self setupTitleLabel];
    [self setupConstraints];
}

- (void)setupImageView
{
    _imageView = [[UIImageView alloc] init];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
}

- (void)setupTitleLabel
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_titleLabel];
}

- (void)setupConstraints
{
    NSDictionary * viewsDictionary = NSDictionaryOfVariableBindings(_imageView, _titleLabel);
    
    NSMutableArray * defaultConstraints = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=0-[_titleLabel]->=0-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:viewsDictionary] mutableCopy];
    [defaultConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=0-[_imageView]->=0-|"
                                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                    metrics:nil
                                                                                      views:viewsDictionary]];
    [defaultConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView][_titleLabel]|"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:viewsDictionary]];

    _modifiableConstraints = [defaultConstraints copy];
    [self addConstraints:_modifiableConstraints];
}

- (void)updateUI
{
    NSDictionary * configurationDictionary = self.configurationsDictionary[[self stateStringKeyForState:self.state]];
    if (!configurationDictionary) {
        configurationDictionary = self.configurationsDictionary[[self stateStringKeyForState:UIControlStateNormal]];
    }
    [self applyConfiguration:configurationDictionary];
}

- (void)applyConfiguration:(NSDictionary *)configurationDictionary
{
    NSString * title = configurationDictionary[titleKey];
    if (title) {
        self.titleLabel.text = title;
    } else {
        NSString * normalStateKey = [self stateStringKeyForState:UIControlStateNormal];
        NSMutableDictionary * normalDictionary = self.configurationsDictionary[normalStateKey];
        self.titleLabel.text = normalDictionary[titleKey] ? : (self.titleLabel.text ? : @"");
    }

    UIColor * titleColor = configurationDictionary[titleColorKey];
    if (titleColor) {
        self.titleLabel.textColor = titleColor;
    } else {
        NSString * normalStateKey = [self stateStringKeyForState:UIControlStateNormal];
        NSMutableDictionary * normalDictionary = self.configurationsDictionary[normalStateKey];
        self.titleLabel.textColor = normalDictionary[titleColorKey] ? : (self.titleLabel.textColor ? : [UIColor whiteColor]);
    }

    UIImage * image = configurationDictionary[imageKey];
    if (image) {
        [self.imageView setImage:image];
    } else {
        NSString * normalStateKey = [self stateStringKeyForState:UIControlStateNormal];
        NSMutableDictionary * normalDictionary = self.configurationsDictionary[normalStateKey];
        UIImage * uiImage = normalDictionary[imageKey] ? : (self.imageView.image ? : nil);
        [self.imageView setImage:uiImage];
    }

    UIColor * backgroundColor = configurationDictionary[backgroundColorKey];
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    } else {
        NSString * normalStateKey = [self stateStringKeyForState:UIControlStateNormal];
        NSMutableDictionary * normalDictionary = self.configurationsDictionary[normalStateKey];
        self.backgroundColor = normalDictionary[backgroundColorKey] ? : (self.backgroundColor ? : [UIColor clearColor]);
    }
}

- (NSMutableDictionary *)configurationForState:(UIControlState)state
{
    NSString * configurationDictionaryKey = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary * configurationDictionary = self.configurationsDictionary[configurationDictionaryKey];
    if (!configurationDictionary) {
        configurationDictionary = [[NSMutableDictionary alloc] init];
        self.configurationsDictionary[configurationDictionaryKey] = configurationDictionary;
    }
    return configurationDictionary;
}

- (NSString *)stateStringKeyForState:(UIControlState)state
{
    return [NSString stringWithFormat:@"%@", @(state)];
}

@end
