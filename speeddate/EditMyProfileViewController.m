//
//  EditMyProfileViewController.m
//  speeddate
//
//  Created by May Yang on 5/3/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "EditMyProfileViewController.h"
#import "UserParseHelper.h"

@interface EditMyProfileViewController ()
@property NSArray *photosArray;
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

@end

@implementation EditMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.photosArray = [NSArray new];
    self.photosArray = [[PFUser currentUser] objectForKey:@"photosArray"];
    
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
    [self.navigationController popViewControllerAnimated:YES];

}

@end
