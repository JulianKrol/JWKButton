//
//  JWKButton.h
//  JWKButton
//
//  Created by Julian Król on 02/05/15.
//  Copyright (c) 2015 Julian Król. All rights reserved.
//

@import UIKit.UIControl;
@import UIKit.UILabel;

@interface JWKButton : UIControl

@property(strong, nonatomic, readonly) UILabel * titleLabel;

- (void)setTitle:(NSString *)title forState:(UIControlState)state;
@end
