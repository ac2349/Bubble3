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
@property NSMutableArray *selectedIndexPathsMutableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSIndexPath *lastIndexPath;
@property NSArray *retrievedIndexPaths;

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
    
    self.selectedIndexPathsMutableArray = [NSMutableArray new];
    self.retrievedIndexPaths = [NSArray new];
}





- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"selectedCells"];
    self.retrievedIndexPaths = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                                                                                                                      
    NSLog(@"%@", self.retrievedIndexPaths);

//    NSNumber *lastRow = [defaults objectForKey:@"selectedCells"];
//    if (lastRow) {
//        self.lastIndexPath = [NSIndexPath indexPathForRow:lastRow.integerValue inSection:0];
//    }
  
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
    
    if ([self.retrievedIndexPaths containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
        [self.selectedIndexPathsMutableArray addObject:self.lastIndexPath];
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
//        self.lastIndexPath = nil;
        [self.selectedRowsArray removeObject:cell.textLabel.text];
        [self.selectedIndexPathsMutableArray removeObject:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%@", self.selectedRowsArray);
    NSLog(@"%@", self.selectedIndexPathsMutableArray);
}

#pragma mark - UIBUTTON

- (IBAction)doneButton:(UIBarButtonItem *)sender
{
    NSLog(@"button pressed");
    
//    NSArray *selectedIndexPathsArray = self.selectedIndexPathsMutableArray;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.selectedIndexPathsMutableArray] forKey:@"selectedCells"];
    [defaults synchronize];
    

    [[PFUser currentUser] setObject:self.selectedRowsArray forKey:@"interests"];
    [[PFUser currentUser] saveInBackground];
}


@end
