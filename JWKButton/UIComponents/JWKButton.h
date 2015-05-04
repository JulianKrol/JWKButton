//
//  JWKButton.h
//  JWKButton
//
//  Created by Julian Król on 02/05/15.
//  Copyright (c) 2015 Julian Król. All rights reserved.
//

@import UIKit.UIControl;
@import UIKit.UILabel;
@import UIKit.UIImageView;

@interface JWKButton : UIControl

@property(strong, nonatomic, readonly) UILabel * titleLabel;
@property(strong, nonatomic, readonly) UIImageView * imageView;

- (void)setTitle:(NSString *)title forState:(UIControlState)state;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

- (void)setImage:(UIImage *)image forState:(UIControlState)state;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end
