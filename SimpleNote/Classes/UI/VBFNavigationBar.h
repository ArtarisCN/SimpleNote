//
//  VBFNavigationBar.h
//  SimpleNote
//
//  Created by Rui.L on 15/8/4.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VBFPopFlatButton/VBFPopFlatButton.h>


typedef NS_ENUM(NSInteger, VBFNavigationButton)
{
    ELeftButton,
    ERightButton,
};

@interface VBFNavigationBar : UIView

typedef void (^ButtonPressBlock)(BOOL success,VBFNavigationButton type);

- (instancetype)initWithButtonType:(FlatButtonType)rightButtonType leftButtonType:(FlatButtonType)leftButtonType title:(NSString *)title frame:(CGRect)rect buttonPressBlock:(ButtonPressBlock)block;

- (BOOL)changeButtonType:(VBFNavigationButton)button type:(FlatButtonType)type;

- (BOOL)hideButton:(VBFNavigationButton)button hide:(BOOL)whetherOrNotHide;

@end
