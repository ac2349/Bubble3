//
//  VipMemberViewController.m
//  speeddate
//
//  Created by studio76 on 06.10.14.
//  Copyright (c) 2014 ivan. All rights reserved.
//

#import "CategoriesViewController.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface CategoriesViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    SKProduct *findProduct;
    UIImageView *logoMember;
    NSArray *allproduct;
}

@property (nonatomic,retain) IBOutlet UIBarButtonItem  *menuBtn;
@property NSMutableArray *categoriesArray;
@property NSMutableArray *selectedRowsArray;
//@property NSMutableArray *checkedArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSIndexPath *lastIndexPath;

@end

@implementation CategoriesViewController


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
    
//    self.checkedArray = [NSMutableArray new];

    
}





- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *lastRow = [defaults objectForKey:@"selectedCell"];
    if (lastRow) {
        self.lastIndexPath = [NSIndexPath indexPathForRow:lastRow.integerValue inSection:0];
    }
  
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
    
    if (self.lastIndexPath == indexPath)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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
        self.lastIndexPath = indexPath;
//        [self.checkedArray addObject:indexPath];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.lastIndexPath = nil;
        [self.selectedRowsArray removeObject:cell.textLabel.text];
//        [self.checkedArray removeObject:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%@", self.selectedRowsArray);
//    NSLog(@"%@", self.checkedArray);
    NSLog(@"%@", self.lastIndexPath);
}

#pragma mark - UIBUTTON

- (IBAction)doneButton:(UIBarButtonItem *)sender
{
    NSLog(@"button pressed");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:(int)self.lastIndexPath.row] forKey:@"selectedCell"];
    [defaults synchronize];
    

    [[PFUser currentUser] setObject:self.selectedRowsArray forKey:@"interests"];
    [[PFUser currentUser] saveInBackground];
}


@end
