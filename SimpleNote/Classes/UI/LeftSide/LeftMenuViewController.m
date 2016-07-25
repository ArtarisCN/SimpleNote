//
//  LeftMenuViewController.m
//  SimpleNote
//
//  Created by Rui.L on 15/8/3.
//  Copyright (c) 2015年 Rui.L. All rights reserved.
//

#import "LeftMenuViewController.h"

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end


@implementation LeftMenuViewController

- (void)loadView
{
//    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width  - 210, [UIScreen mainScreen].bounds.size.height);
    [super loadView];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.separatorInset = UIEdgeInsetsMake(0, 0,0 , self.view.frame.size.width - 210);

        tableView.backgroundColor = [UIColor cyanColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.bounces = YES;
        
        tableView;
    });
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, footView.frame.size.width * 0.6, 50)];
    [footView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"V 0.9\nCopyright © 2015,Rui.L \n All Right Reserved.";
    label.numberOfLines = 4;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor lightGrayColor];
    //    [label sizeToFit];
    self.tableView.tableFooterView = footView;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            //            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[DEMOFirstViewController alloc] init]]
            //                                                         animated:YES];
            //            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            //            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[DEMOSecondViewController alloc] init]]
            //                                                         animated:YES];
            //            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"Home", @"Calendar", @"Profile", @"Settings", @"Log Out"];
    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    if(indexPath.section == 0)
        cell.textLabel.text = titles[indexPath.row];
    else
        cell.textLabel.text = images[indexPath.row];
    //    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}


@end
