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
#import "MyProfileCollectionViewCell.h"

@interface MyProfileViewController () <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *pageImages;
@property (strong, nonatomic) NSMutableArray *pageViews;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
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
    
    self.pageImages = [[PFUser currentUser] objectForKey:@"photosArray"];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.widthConstraint.constant = self.scrollView.frame.size.width;

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.scrollView.frame.size.width, self.collectionView.frame.size.height);
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyProfileCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"profileCell" forIndexPath:indexPath];
    NSString *urlJPG = [self.pageImages objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:urlJPG];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        cell.imageView.image = [UIImage imageWithData:data];
    }];
    return cell;
}

@end
