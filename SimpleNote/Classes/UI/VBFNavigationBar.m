//
//  VBFNavigationBar.m
//  SimpleNote
//
//  Created by Rui.L on 15/8/4.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import "VBFNavigationBar.h"
#import <UIColor+FlatColors/UIColor+FlatColors.h>
//#import <RESideMenu/RESideMenu.h>

@interface VBFNavigationBar()

@property (nonatomic,strong) ButtonPressBlock block;

@property (nonatomic, strong) VBFPopFlatButton *flatNaviLeftButton;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) VBFPopFlatButton *flatNaviRightButton;

@end

@implementation VBFNavigationBar



- (instancetype)initWithButtonType:(FlatButtonType)rightButtonType leftButtonType:(FlatButtonType)leftButtonType title:(NSString *)title frame:(CGRect)rect buttonPressBlock:(ButtonPressBlock)block 
{
    if(self = [super init])
    {
        self.block = block;
        self.backgroundColor = [UIColor flatWisteriaColor];
        
        self.frame = rect;
        self.title = [[UILabel alloc] init];
        self.title.text = title;

        self.title.textColor = [UIColor flatPeterRiverColor];
        [self.title sizeToFit];
        self.title.frame = CGRectMake(self.frame.size.width / 2 - self.title.frame.size.width / 2, 10, self.title.frame.size.width, 25);
        [self addSubview:self.title];
        
        self.flatNaviLeftButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(10, 10, 25, 25)
                                                               buttonType:leftButtonType
                                                              buttonStyle:buttonPlainStyle
                                                    animateToInitialState:YES];
        self.flatNaviLeftButton.roundBackgroundColor = [UIColor whiteColor];
        self.flatNaviLeftButton.lineThickness = 3;
        self.flatNaviLeftButton.lineRadius = 1;
        self.flatNaviLeftButton.tintColor = [UIColor flatPeterRiverColor];
        [self.flatNaviLeftButton addTarget:self
                                    action:@selector(leftButtonPressed)
                          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.flatNaviLeftButton];

        self.flatNaviRightButton = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 25, 25)
                                                                buttonType:rightButtonType
                                                               buttonStyle:buttonPlainStyle
                                                     animateToInitialState:YES];
        self.flatNaviRightButton.roundBackgroundColor = [UIColor whiteColor];
        self.flatNaviRightButton.lineThickness = 3;
        self.flatNaviRightButton.lineRadius = 1;
        self.flatNaviRightButton.tintColor = [UIColor flatPeterRiverColor];
        [self.flatNaviRightButton addTarget:self
                                    action:@selector(rightButtonPressed)
                          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.flatNaviRightButton];
    }
    return self;
}

- (BOOL)changeButtonType:(VBFNavigationButton)button type:(FlatButtonType)type
{
    if(button == ELeftButton)
    {
        [self.flatNaviLeftButton animateToType:type];
        return YES;
    }
    else if (button == ERightButton)
    {
        [self.flatNaviRightButton animateToType:type];
        return YES;
    }
    return NO;
}

- (BOOL)hideButton:(VBFNavigationButton)button hide:(BOOL)whetherOrNotHide
{
    if(button == ELeftButton)
    {
        self.flatNaviLeftButton.hidden = whetherOrNotHide;
        return YES;
    }
    else if (button == ERightButton)
    {
        self.flatNaviRightButton.hidden = whetherOrNotHide;
        return YES;
    }
    return NO;
}

- (void)leftButtonPressed
{
    self.block(YES,ELeftButton);
}

- (void)rightButtonPressed
{
    self.block(YES,ERightButton);
}

@end
