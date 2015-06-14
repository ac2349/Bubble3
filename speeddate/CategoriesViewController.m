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
#import "UserParseHelper.h"

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
@property NSString *happyHour;
@property NSString *outdoors;
@property NSString *dining;
@property NSString *travelers;
@property NSString *fitness;


@end

@implementation CategoriesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.tableView.backgroundColor = [UIColor clearColor];

    
    self.categoriesArray = [[NSMutableArray alloc] initWithObjects:@"Happy Hour", @"Dining", @"Outdoors", @"Travelers", @"Fitness", nil];
    self.selectedRowsArray = [NSMutableArray new];
    
    self.selectedIndexPathsMutableArray = [NSMutableArray new];
    self.retrievedIndexPaths = [NSArray new];
    

    self.happyHour = @"";
    self.dining = @"";
    self.outdoors = @"";
    self.fitness = @"";
    self.travelers = @"";
    
    
    
}





- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"selectedCells"];
    self.retrievedIndexPaths = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                                                                                                                      
    NSLog(@"%@", self.retrievedIndexPaths);
  
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
        // add this to self.selectedRowsArray;
        [self.selectedIndexPathsMutableArray addObject:indexPath];
        [self.selectedRowsArray addObject:cell.textLabel.text];
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

    
    for (NSString *interest in self.selectedRowsArray)
    {
        if ([interest isEqualToString:@"Happy Hour"])
        {
            self.happyHour = @"hasHappyHour";
        }
        
        if ([interest isEqualToString:@"Fitness"])
        {
            self.fitness = @"hasFitness";
        }
        
        if ([interest isEqualToString:@"Dining"])
        {
            self.dining = @"hasDining";
        }
        
        if ([interest isEqualToString:@"Outdoors"])
        {
            self.outdoors = @"hasOutdoors";
        }

        if ([interest isEqualToString:@"Travelers"])
        {
            self.travelers = @"hasTravelers";
        }


    }
    
    
    [[PFUser currentUser] setObject:self.happyHour forKey:@"happyHour"];
    [[PFUser currentUser] saveInBackground];
    
    [[PFUser currentUser] setObject:self.fitness forKey:@"fitness"];
    [[PFUser currentUser] saveInBackground];
    
    [[PFUser currentUser] setObject:self.outdoors forKey:@"outdoors"];
    [[PFUser currentUser] saveInBackground];
    
    [[PFUser currentUser] setObject:self.travelers forKey:@"travelers"];
    [[PFUser currentUser] saveInBackground];
    
    [[PFUser currentUser] setObject:self.dining forKey:@"dining"];
    [[PFUser currentUser] saveInBackground];
    
    
    [self performSegueWithIdentifier:@"chooseCategoriesToEditInfo" sender:self];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
