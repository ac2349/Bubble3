//
//  VipMemberViewController.m
//  speeddate
//
//  Created by studio76 on 06.10.14.
//  Copyright (c) 2014 ivan. All rights reserved.
//

#import "VipMemberViewController.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>
//#import "PurchaseHelper.h"
#import "SWRevealViewController.h"

@interface VipMemberViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    SKProduct *findProduct;
    UIImageView *logoMember;
    NSArray *allproduct;
}

@property (nonatomic,retain) IBOutlet UIBarButtonItem  *menuBtn;
@property NSMutableArray *categoriesArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VipMemberViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuBtn.target = self.revealViewController;
     _menuBtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
     UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setShadowImage:[UIImage new]];
    
    self.tableView.backgroundColor = [UIColor clearColor];

    
    self.categoriesArray = [[NSMutableArray alloc] initWithObjects:@"Happy Hour", @"Dining", @"Outdoors", @"Travelers", @"Fitness",  nil];
    
//    [self.tableView reloadData];
    
    
}





- (void)viewWillAppear:(BOOL)animated {
  
//    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITABLEVIEW DELEGATE
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.categoriesArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
//    
//    if ([self.categoriesArray containsObject:indexPath])
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoriesArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        <#statements#>
    }
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    if ([self.categoriesArray containsObject:indexPath])
//    {
//        [self.categoriesArray removeObject:indexPath];
//    }
//    else
//    {
//        [self.categoriesArray addObject:indexPath];
//    }
//    
//    [self.tableView reloadData];
}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryNone;
//}


@end
