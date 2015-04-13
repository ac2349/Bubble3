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

@interface MyProfileViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *innerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property BOOL pageControlBeingUsed;
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
    
//    [[UserParseHelper currentUser].photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
//    {
//        self.profileImageView.image = [[UIImage alloc] initWithData:data];
//    }];
    
    self.pageControlBeingUsed = NO;

    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.innerScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.innerScrollView addSubview:subview];
    }
    
    self.innerScrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = colors.count;


}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;

}

#pragma mark - UISCROLLVIEW DELEGATE

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!self.pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.innerScrollView.frame.size.width;
        int page = floor((self.innerScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControlBeingUsed = NO;
}

#pragma mark - IBACTIONS

- (IBAction)changePage:(UIPageControl *)sender
{
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.innerScrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.innerScrollView.frame.size;
    [self.innerScrollView scrollRectToVisible:frame animated:YES];
    
    // Keep track of when scrolls happen in response to the page control
    // value changing. If we don't do this, a noticeable "flashing" occurs
    // as the the scroll delegate will temporarily switch back the page
    // number.
    self.pageControlBeingUsed = YES;
}

@end
