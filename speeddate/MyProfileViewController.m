//
//  MyProfileViewController.m
//  speeddate
//
//  Created by May Yang on 4/4/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "MyProfileViewController.h"
#import "UserParseHelper.h"
#import "SWRevealViewController.h"

@interface MyProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property UserParseHelper *user;
@end

@implementation MyProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [UserParseHelper currentUser].nickname;
    
    self.sidebarButton.target = self.revealViewController;
    self.sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [[UserParseHelper currentUser].photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
    {
        self.profileImageView.image = [[UIImage alloc] initWithData:data];
    }];


}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

@end
