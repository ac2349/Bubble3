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
@property NSMutableArray *selectedRowsArray;
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
    self.selectedRowsArray = [NSMutableArray new];
    
//    [self.tableView reloadData];
    
    
}





- (void)viewWillAppear:(BOOL)animated {
  
//    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(NSArray *)getSelections
//{
//    NSMutableArray *selections = [NSMutableArray new];
//    
//    for (NSIndexPath *indexPath in self.selectedRowsArray)
//    {
//        [selections addObject:[self.categoriesArray objectAtIndex:indexPath.row]];
//    }
//    
//    return selections;
//}

#pragma mark - UITABLEVIEW DELEGATE
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.categoriesArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
//    if ([self.selectedRowsArray containsObject:indexPath])
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoriesArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedRowsArray addObject:cell.textLabel.text];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedRowsArray removeObject:cell.textLabel.text];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%@", self.selectedRowsArray);
    
}


@end
