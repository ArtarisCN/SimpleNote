//
//  NewNoteViewController.m
//  SimpleNote
//
//  Created by Rui.L on 15/8/3.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import "NoteModel.h"

#import "NewNoteViewController.h"
#import "VBFNavigationBar.h"

#import <UIColor+FlatColors/UIColor+FlatColors.h>


@interface NewNoteViewController()

@property (nonatomic, strong) VBFNavigationBar *navigationbar;

@end


@implementation NewNoteViewController


- (instancetype)initWithNote:(NoteModel *)note
{
    if(self = [super init])
    {
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationbar hideButton:ELeftButton hide:NO];
    [self.navigationbar hideButton:ERightButton hide:NO];
}

- (void) loadView
{
    [super loadView];

    CGRect statusBarFrame = CGRectMake(0, 0, self.view.frame.size.width, 20);
    UIView *myStatusBar = [[UIView alloc] initWithFrame:statusBarFrame];
    myStatusBar.backgroundColor = [UIColor flatWisteriaColor];
    [self.view addSubview:myStatusBar];
    
    CGRect navigationFrame = CGRectMake(0, 20, self.view.frame.size.width, 46);
    self.navigationbar = [[VBFNavigationBar alloc] initWithButtonType:buttonOkType
                                                       leftButtonType:buttonBackType
                                                                title:nil
                                                                frame:navigationFrame
                                                     buttonPressBlock:^(BOOL success, VBFNavigationButton type)
                                                    {
                                                        if(success)
                                                        {
                                                            BOOL changeSuccess;
                                                            if(type == ELeftButton)
                                                            {
                                                                [self.navigationbar changeButtonType:ELeftButton type:buttonMenuType];
                                                                [self.navigationbar changeButtonType:ERightButton type:buttonAddType];
                                                                [self.navigationController popViewControllerAnimated:YES];
                                                            }
                                                            else if(type == ERightButton)
                                                            {
                                                                changeSuccess = [self.navigationbar changeButtonType:ELeftButton type:buttonMenuType];
                                                                [self.navigationbar changeButtonType:ERightButton type:buttonAddType];

                                                                [self.navigationController popViewControllerAnimated:YES];
                                                            }
                                                        }
                                                    }];
    
    [self.view addSubview:self.navigationbar];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationbar hideButton:ELeftButton hide:YES];
    [self.navigationbar hideButton:ERightButton hide:YES];

}

@end
