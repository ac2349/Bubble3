//
//  EditMyProfileViewController.m
//  speeddate
//
//  Created by May Yang on 5/3/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "EditMyProfileViewController.h"
#import "UserParseHelper.h"

@interface EditMyProfileViewController () <UIActionSheetDelegate>
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
@end

@implementation EditMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
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

    
    
}

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

@end
