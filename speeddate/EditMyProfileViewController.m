//
//  EditMyProfileViewController.m
//  speeddate
//
//  Created by May Yang on 5/3/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "EditMyProfileViewController.h"
#import "UserParseHelper.h"

@interface EditMyProfileViewController () <UIActionSheetDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property NSMutableArray *photosArray;
@property (weak, nonatomic) IBOutlet UIImageView *photoOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoFourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoFiveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoSixImageView;
@property NSString *photoOneURL;
@property NSString *photoTwoURL;
@property NSString *photoThreeURL;
@property NSString *photoFourURL;
@property NSString *photoFiveURL;
@property NSString *photoSixURL;
@property BOOL photoOneSelected;
@property BOOL photoTwoSelected;
@property BOOL photoThreeSelected;
@property BOOL photoFourSelected;
@property BOOL photoFiveSelected;
@property BOOL photoSixSelected;
@property (weak, nonatomic) IBOutlet UILabel *aboutMeLabel;
@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;
@property (weak, nonatomic) IBOutlet UILabel *aboutMeCharacterLimitLabel;
@property (weak, nonatomic) IBOutlet UITextView *lookingForTextView;
@property (weak, nonatomic) IBOutlet UILabel *lookingForCharacterLimit;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *editProfileArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property NSString *interestOne;
@property NSString *interestTwo;
@property NSString *interestThree;
@property NSString *interestFour;
@property NSString *interestFive;
@property NSArray *interestsArray;

@end

@implementation EditMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.editProfileArray = [[NSArray alloc] initWithObjects:@"Categories", @"Gender", nil];
    self.interestsArray = [NSArray new];
    self.photosArray = [NSMutableArray new];
    self.photosArray = [[PFUser currentUser] objectForKey:@"photosArray"];
    
    if (self.photosArray.count == 1)
    {
        for (NSString *stringItem in self.photosArray)
        {
            if ([self.photosArray objectAtIndex:0])
            {
                self.photoOneURL = [self.photosArray objectAtIndex:0];
            }
            
        }
        
    }
    
    if (self.photosArray.count == 2)
    {
        for (NSString *stringItem in self.photosArray)
        {
            if ([self.photosArray objectAtIndex:0])
            {
                self.photoOneURL = [self.photosArray objectAtIndex:0];
            }
            if ([self.photosArray objectAtIndex:1])
            {
                self.photoTwoURL = [self.photosArray objectAtIndex:1];
            }
            
        }
        
    }
    
    if (self.photosArray.count == 3)
    {
        for (NSString *stringItem in self.photosArray)
        {
            if ([self.photosArray objectAtIndex:0])
            {
                self.photoOneURL = [self.photosArray objectAtIndex:0];
            }
            if ([self.photosArray objectAtIndex:1])
            {
                self.photoTwoURL = [self.photosArray objectAtIndex:1];
            }
            if ([self.photosArray objectAtIndex:2])
            {
                self.photoThreeURL = [self.photosArray objectAtIndex:2];
            }
            
        }
        
    }
    
    if (self.photosArray.count == 4)
    {
        for (NSString *stringItem in self.photosArray)
        {
            if ([self.photosArray objectAtIndex:0])
            {
                self.photoOneURL = [self.photosArray objectAtIndex:0];
            }
            if ([self.photosArray objectAtIndex:1])
            {
                self.photoTwoURL = [self.photosArray objectAtIndex:1];
            }
            if ([self.photosArray objectAtIndex:2])
            {
                self.photoThreeURL = [self.photosArray objectAtIndex:2];
            }
            if ([self.photosArray objectAtIndex:3])
            {
                self.photoFourURL = [self.photosArray objectAtIndex:3];
            }
            
        }

    }
    
    if (self.photosArray.count == 5)
    {
        for (NSString *stringItem in self.photosArray)
        {
            if ([self.photosArray objectAtIndex:0])
            {
                self.photoOneURL = [self.photosArray objectAtIndex:0];
            }
            if ([self.photosArray objectAtIndex:1])
            {
                self.photoTwoURL = [self.photosArray objectAtIndex:1];
            }
            if ([self.photosArray objectAtIndex:2])
            {
                self.photoThreeURL = [self.photosArray objectAtIndex:2];
            }
            if ([self.photosArray objectAtIndex:3])
            {
                self.photoFourURL = [self.photosArray objectAtIndex:3];
            }
            if ([self.photosArray objectAtIndex:4])
            {
                self.photoFiveURL = [self.photosArray objectAtIndex:4];
            }
            
        }

    }
    
    if (self.photosArray.count == 6)
    {
        for (NSString *stringItem in self.photosArray)
        {
            if ([self.photosArray objectAtIndex:0])
            {
                self.photoOneURL = [self.photosArray objectAtIndex:0];
            }
            if ([self.photosArray objectAtIndex:1])
            {
                self.photoTwoURL = [self.photosArray objectAtIndex:1];
            }
            if ([self.photosArray objectAtIndex:2])
            {
                self.photoThreeURL = [self.photosArray objectAtIndex:2];
            }
            if ([self.photosArray objectAtIndex:3])
            {
                self.photoFourURL = [self.photosArray objectAtIndex:3];
            }
            if ([self.photosArray objectAtIndex:4])
            {
                self.photoFiveURL = [self.photosArray objectAtIndex:4];
            }
            if ([self.photosArray objectAtIndex:5])
            {
                self.photoSixURL = [self.photosArray objectAtIndex:5];
            }
            
        }
    }
    

    [self downloadImageWithURL:[NSURL URLWithString:self.photoOneURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        self.photoOneImageView.image = image;
    }];
    [self downloadImageWithURL:[NSURL URLWithString:self.photoTwoURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        self.photoTwoImageView.image = image;
    }];
    [self downloadImageWithURL:[NSURL URLWithString:self.photoThreeURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        self.photoThreeImageView.image = image;
    }];
    [self downloadImageWithURL:[NSURL URLWithString:self.photoFourURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        self.photoFourImageView.image = image;
    }];
    [self downloadImageWithURL:[NSURL URLWithString:self.photoFiveURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        self.photoFiveImageView.image = image;
    }];
    [self downloadImageWithURL:[NSURL URLWithString:self.photoSixURL] completionBlock:^(BOOL succeeded, UIImage *image) {
        self.photoSixImageView.image = image;
    }];
    
    self.aboutMeLabel.text = [NSString stringWithFormat:@"About %@", [UserParseHelper currentUser].nickname];
    [self.aboutMeTextView setScrollEnabled:NO];
    
    [self.lookingForTextView setScrollEnabled:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView *view in self.scrollView.subviews) {
        scrollViewHeight += view.frame.size.height;
    }
   [self.scrollView setContentSize:(CGSizeMake(320, scrollViewHeight))];
    NSLog(@"scrollview content size height is %f", self.scrollView.contentSize.height);
    NSLog(@"%f", scrollViewHeight);
}

#pragma mark - ASYNCHRONOUS IMAGE DOWNLOAD HELPER

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

#pragma mark - IBACTIONS

- (IBAction)doneButton:(UIBarButtonItem *)sender
{
    [[PFUser currentUser] saveInBackground];
    [self performSegueWithIdentifier:@"editProfileToProfileSegue" sender:self];
}

- (IBAction)showActionSheetForPhotoOne:(id)sender
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [popupQuery showInView:self.view];
    
    self.photoOneSelected = YES;
}

- (IBAction)showActionSheetForPhotoTwo:(UIButton *)sender
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [popupQuery showInView:self.view];
    
    self.photoTwoSelected = YES;
    
}

- (IBAction)showActionSheetForPhotoThree:(UIButton *)sender
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [popupQuery showInView:self.view];
    
    self.photoThreeSelected = YES;
}

- (IBAction)showActionSheetForPhotoFour:(UIButton *)sender
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [popupQuery showInView:self.view];
    
    self.photoFourSelected = YES;
}

- (IBAction)showActionSheetForPhotoFive:(UIButton *)sender
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [popupQuery showInView:self.view];
    
    self.photoFiveSelected = YES;
}

- (IBAction)showActionSheetForPhotoSix:(UIButton *)sender
{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    [popupQuery showInView:self.view];
    
    self.photoSixSelected = YES;
}


#pragma  mark - UIACTION SHEET DELEGATE METHODS

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.photoOneSelected == YES)
        {
            NSLog(@"PHOTO ONE SELECTED");
            self.photoOneSelected = NO;
            
            // remove image
            self.photoOneImageView.image = nil;
            
            // update array locally
            [self.photosArray removeObjectAtIndex:0];
            NSLog(@"%@", self.photosArray);
            
            // update array on parse
            [[PFUser currentUser] setObject:self.photosArray forKey:@"photosArray"];
        }
        else if (self.photoTwoSelected == YES)
        {
            NSLog(@"PHOTO TWO SELECTED");
            self.photoTwoSelected = NO;
            
            // remove image
            self.photoTwoImageView.image = nil;
            
            // update array locally
            [self.photosArray removeObjectAtIndex:1];
            NSLog(@"%@", self.photosArray);
            
            // update array on parse
            [[PFUser currentUser] setObject:self.photosArray forKey:@"photosArray"];

        }
        else if (self.photoThreeSelected == YES)
        {
            NSLog(@"PHOTO THREE SELECTED");
            self.photoThreeSelected = NO;
            
            // remove image
            self.photoThreeImageView.image = nil;
            
            // update array locally
            [self.photosArray removeObjectAtIndex:2];
            NSLog(@"%@", self.photosArray);
            
            // update array on parse
            [[PFUser currentUser] setObject:self.photosArray forKey:@"photosArray"];

        }
        else if (self.photoFourSelected == YES)
        {
            NSLog(@"PHOTO FOUR SELECTED");
            self.photoFourSelected = NO;
            
            // remove image
            self.photoFourImageView.image = nil;
            
            // update array locally
            [self.photosArray removeObjectAtIndex:3];
            NSLog(@"%@", self.photosArray);
            
            // update array on parse
            [[PFUser currentUser] setObject:self.photosArray forKey:@"photosArray"];


        }
        else if (self.photoFiveSelected == YES)
        {
            NSLog(@"PHOTO FIVE SELECTED");
            self.photoFiveSelected = NO;
            
            // remove image
            self.photoFiveImageView.image = nil;
            
            // update array locally
            [self.photosArray removeObjectAtIndex:4];
            NSLog(@"%@", self.photosArray);
            
            // update array on parse
            [[PFUser currentUser] setObject:self.photosArray forKey:@"photosArray"];


        }
        else if (self.photoSixSelected == YES)
        {
            NSLog(@"PHOTO SIX SELECTED");
            self.photoSixSelected = NO;
            
            // remove image
            self.photoSixImageView.image = nil;
            
            // update array locally
            [self.photosArray removeObjectAtIndex:5];
            NSLog(@"%@", self.photosArray);
            
            // update array on parse
            [[PFUser currentUser] setObject:self.photosArray forKey:@"photosArray"];


        }
    }
}

#pragma mark - UITEXTVIEWDELEGATE
- (void)textViewDidChange:(UITextView *)textView
{
    // About Me Text View
    CGFloat aboutMeFixedWidth = self.aboutMeTextView.frame.size.width;
    CGSize aboutMeNewSize = [self.aboutMeTextView sizeThatFits:CGSizeMake(aboutMeFixedWidth, MAXFLOAT)];
    CGRect aboutMeNewFrame = self.aboutMeTextView.frame;
    aboutMeNewFrame.size = CGSizeMake(fmaxf(aboutMeNewSize.width, aboutMeFixedWidth), aboutMeNewSize.height);
    self.aboutMeTextView.frame = aboutMeNewFrame;
    NSLog(@"about me textview new height is %f", aboutMeNewFrame.size.height);
    
    CGRect bottomViewNewFrame = self.bottomView.frame;
    
    bottomViewNewFrame.size.height = bottomViewNewFrame.size.height + aboutMeNewFrame.size.height;
    NSLog(@"bottomview height new height is %f", bottomViewNewFrame.size.height);
    
//    [self.bottomView setFrame:bottomViewNewFrame];
    

    self.aboutMeTextView.scrollEnabled = NO;
    
    long aboutMeLength = self.aboutMeTextView.text.length;
    self.aboutMeCharacterLimitLabel.text = [NSString stringWithFormat:@"%li", 500 - aboutMeLength];
    
    // Looking For Text View
    CGFloat lookingForFixedWidth = self.lookingForTextView.frame.size.width;
    CGSize lookingForNewSize = [self.lookingForTextView sizeThatFits:CGSizeMake(lookingForFixedWidth, MAXFLOAT)];
    CGRect lookingForNewFrame = self.lookingForTextView.frame;
    lookingForNewFrame.size = CGSizeMake(fmaxf(lookingForNewSize.width, lookingForFixedWidth), lookingForNewSize.height);
    self.lookingForTextView.frame = lookingForNewFrame;
    
    self.lookingForTextView.scrollEnabled = NO;
    
    long lookingForLength = self.lookingForTextView.text.length;
    self.lookingForCharacterLimit.text = [NSString stringWithFormat:@"%li", 500 - lookingForLength];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length + range.location > textView.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return newLength <= 500;
}

#pragma mark - UITABLEVIEWDELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.editProfileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editProfileCell"];
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    cell.textLabel.font = font;
    cell.textLabel.text = self.editProfileArray[indexPath.row];

    if (indexPath.row == 0)
    {
        if ([UserParseHelper currentUser].interests)
        {
            self.interestsArray = [UserParseHelper currentUser].interests;

            if ([self.interestsArray count] == 0)
            {
                cell.detailTextLabel.text = @"Add Categories";
            }
            else
            {
                for (NSString *string in self.interestsArray)
                {
                    if (self.interestsArray.count == 1)
                    {
                        self.interestOne = [self.interestsArray objectAtIndex:0];
                        cell.detailTextLabel.text = self.interestOne;
                    }
                    else if (self.interestsArray.count == 2)
                    {
                        self.interestOne = [self.interestsArray objectAtIndex:0];
                        self.interestTwo = [self.interestsArray objectAtIndex:1];
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", self.interestOne, self.interestTwo];
                    }
                    else if (self.interestsArray.count == 3)
                    {
                        self.interestOne = [self.interestsArray objectAtIndex:0];
                        self.interestTwo = [self.interestsArray objectAtIndex:1];
                        self.interestThree = [self.interestsArray objectAtIndex:2];
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@", self.interestOne, self.interestTwo, self.interestThree];
                    }
                    else if (self.interestsArray.count == 4)
                    {
                        self.interestOne = [self.interestsArray objectAtIndex:0];
                        self.interestTwo = [self.interestsArray objectAtIndex:1];
                        self.interestThree = [self.interestsArray objectAtIndex:2];
                        self.interestFour = [self.interestsArray objectAtIndex:3];
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@, %@", self.interestOne, self.interestTwo, self.interestThree, self.interestFour];
                    }
                    else if (self.interestsArray.count == 5)
                    {
                        self.interestOne = [self.interestsArray objectAtIndex:0];
                        self.interestTwo = [self.interestsArray objectAtIndex:1];
                        self.interestThree = [self.interestsArray objectAtIndex:2];
                        self.interestFour = [self.interestsArray objectAtIndex:3];
                        self.interestFive = [self.interestsArray objectAtIndex:4];
                        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@, %@, %@", self.interestOne, self.interestTwo, self.interestThree, self.interestFour, self.interestFive];
                    }
                    
                    
                }

            }
                    }
        else
        {
            cell.detailTextLabel.text = @"Add Categories";
        }

    }
    else
    {
        cell.detailTextLabel.text = [UserParseHelper currentUser].gender;
    }

    
        cell.detailTextLabel.font = font;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"editProfileToChooseCategories" sender:self];
        NSLog(@"test");
    }
    else if (indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"editProfileToGenderVCSegue" sender:self];
    }
    
}

@end
