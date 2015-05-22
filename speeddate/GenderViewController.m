//
//  GenderViewController.m
//  speeddate
//
//  Created by May Yang on 5/12/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "GenderViewController.h"
#import "UserParseHelper.h"

@interface GenderViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *genderArray;
@property NSIndexPath *checkedIndexPath;
@property NSString *theNewSex;

@end

@implementation GenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.navigationItem.title = @"I Am";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton:)];

    self.genderArray = [[NSArray alloc]initWithObjects:@"Male", @"Female", nil];
}

-(IBAction)doneButton:(id)sender
{
    [self performSegueWithIdentifier:@"genderToEditProfileSegue" sender:self];
    
    [[UserParseHelper currentUser] setObject:self.theNewSex forKey:@"gender"];
    [[UserParseHelper currentUser] saveInBackground];
}

#pragma mark - UITABLEVIEW DELEGATE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.genderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"genderCell"];
    cell.textLabel.text = self.genderArray[indexPath.row];
    
    if (([UserParseHelper currentUser].gender = @"Female"))
    {
        if (indexPath.row == 1)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.checkedIndexPath = indexPath;
        }

    }
    else if (([UserParseHelper currentUser].gender = @"Male"))
    {
        if (indexPath.row == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.checkedIndexPath = indexPath;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    
    self.theNewSex = cell.textLabel.text;
    NSLog(@"%@", self.theNewSex);


}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

}


@end
