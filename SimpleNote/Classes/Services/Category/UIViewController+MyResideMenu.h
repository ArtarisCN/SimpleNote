//
//  UIViewController+MyResideMenu.h
//  SimpleNote
//
//  Created by Rui.L on 15/8/3.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RESideMenu;



@interface UIViewController (MyResideMenu)

@property (strong, readonly, nonatomic) RESideMenu *sideMenuViewController;

- (IBAction)presentMyLeftMenuViewController:(id)sender;
- (IBAction)presentRightMenuViewController:(id)sender;

@end
