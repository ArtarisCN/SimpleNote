
//
//  MainViewController.m
//  SimpleNote
//
//  Created by Rui.L on 15/8/3.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import "MainViewController.h"
#import "NewNoteViewController.h"

#import "VBFNavigationBar.h"
#import "NoteCell.h"

#import "NoteModel.h"

#import <VBFPopFlatButton/VBFPopFlatButton.h>
#import <UIColor+FlatColors/UIColor+FlatColors.h>
#import <RESideMenu/RESideMenu.h>

@interface MainViewController()<RESideMenuDelegate,UITableViewDataSource, UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *noteTable;
@property (strong, readonly, nonatomic) RESideMenu *sideMenuViewController;
@property (nonatomic, strong) VBFNavigationBar *navigationbar;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allNotes;
@property (nonatomic, strong) NSMutableArray *filteredNotes;

@end


@implementation MainViewController

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationbar hideButton:ELeftButton hide:NO];
    [self.navigationbar hideButton:ERightButton hide:NO];
    [self.navigationbar changeButtonType:ERightButton type:buttonAddType];
    [self.navigationbar changeButtonType:ELeftButton type:buttonMenuType];
}

- (void)loadView
{
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sideMenuDidHideMenuViewController:)
                                                 name:@"SideDidHide"
                                               object:nil];
    
    CGRect statusBarFrame = CGRectMake(0, 0, self.view.frame.size.width, 20);
    
    UIView *myStatusBar = [[UIView alloc] initWithFrame:statusBarFrame];
    myStatusBar.backgroundColor = [UIColor flatWisteriaColor];
    [self.view addSubview:myStatusBar];
    
    CGRect navigationFrame = CGRectMake(0, 20, self.view.frame.size.width, 46);
    self.navigationbar = [[VBFNavigationBar alloc] initWithButtonType:buttonAddType
                                                       leftButtonType:buttonMenuType
                                                                title:@"便签"
                                                                frame:navigationFrame
                                                     buttonPressBlock:^(BOOL success, VBFNavigationButton type)
                          {
                              if(success)
                              {
                                  BOOL changeSuccess;
                                  if(type == ELeftButton)
                                  {
                                      changeSuccess = [self.navigationbar changeButtonType:ELeftButton type:buttonForwardType];
                                      
                                      [self.sideMenuViewController presentLeftMenuViewController];
                                  }
                                  else if(type == ERightButton)
                                  {
                                      NewNoteViewController *vc = [NewNoteViewController new];
                                      [self.navigationbar changeButtonType:ERightButton type:buttonOkType];
                                      [self.navigationbar changeButtonType:ELeftButton type:buttonBackType];
                                      
                                      [self.navigationController pushViewController:vc animated:YES];
                                  }
                              }
                          }];
    
    [self.view addSubview:self.navigationbar];
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 70,0 , 0);
    [self.view addSubview:self.tableView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];



    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
        cell = [[NoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    [cell bindWithWeiboModel:self.weiboStatueArray[indexPath.row] withDelegate:self];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allNotes.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteModel *note = [self.allNotes objectAtIndex:[indexPath row]];
    NewNoteViewController *vc = [[NewNoteViewController alloc] initWithNote:note];
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filteredNotes removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchController.searchBar.text];
    self.filteredNotes = [[self.allNotes filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)sideMenuDidHideMenuViewController:(NSNotification *) notif
{
    [self.navigationbar changeButtonType:ELeftButton type:buttonMenuType];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationbar hideButton:ELeftButton hide:YES];
    [self.navigationbar hideButton:ERightButton hide:YES];
    
}
@end
