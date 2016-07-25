//
//  UIViewController+MyResideMenu.m
//  SimpleNote
//
//  Created by Rui.L on 15/8/3.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import "UIViewController+MyResideMenu.h"
#import "RESideMenu.h"


@implementation UIViewController (MyResideMenu)

- (RESideMenu *)sideMenuViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[RESideMenu class]]) {
            return (RESideMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark IB Action Helper methods

- (IBAction)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)presentRightMenuViewController:(id)sender
{
    [self.sideMenuViewController presentRightMenuViewController];
}


@end
