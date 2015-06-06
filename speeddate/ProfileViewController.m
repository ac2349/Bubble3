//
//  ProfileViewController.m
//  speeddate
//
//  Created by May Yang on 5/31/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"

@interface ProfileViewController () <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *pageImages;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (strong, nonatomic) NSMutableArray *pageViews;
@property (weak, nonatomic) IBOutlet UILabel *nameAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UITextView *aboutMeTextView;
@property (weak, nonatomic) IBOutlet UITextView *lookingForTextView;
@property NSArray *interestsArray;
@property (weak, nonatomic) IBOutlet UILabel *topInterestsLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Profile";
    
    self.pageImages = self.chosenUser.photosArray;
    
    self.nameAgeLabel.text = [NSString stringWithFormat:@"%@, %@", self.chosenUser.nickname, self.chosenUser.age];

    self.locationLabel.text = [NSString stringWithFormat:@"Lives in %@", self.chosenUser.location];
    
    self.aboutMeTextView.text = self.chosenUser.description;
    
    self.lookingForTextView.text = self.chosenUser.lookingFor;
    
    [self getInterests];
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.widthConstraint.constant = self.scrollView.frame.size.width;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.scrollView.frame.size.width, self.collectionView.frame.size.height);

}

#pragma mark - POPULATE DATA
- (void)getInterests
{
    self.interestsArray = self.chosenUser.interests;
    
    if (self.interestsArray.count >= 3)
    {
        NSArray *tempArray = [self.interestsArray subarrayWithRange:NSMakeRange(0, 3)];
        for (NSString *interestString in tempArray)
        {
            NSString *interestOne = [tempArray objectAtIndex:0];
            NSString *interestTwo = [tempArray objectAtIndex:1];
            NSString *interestThree = [tempArray objectAtIndex:2];
            
            self.topInterestsLabel.text = [NSString stringWithFormat:@"Top Interests: %@, %@, %@", interestOne, interestTwo, interestThree];
            
            NSLog(@"%@", interestString);
        }
    }
    else
    {
        for (NSString *interestString in self.interestsArray)
        {
            if (self.interestsArray.count == 2)
            {
                NSString *interestOne = [self.interestsArray objectAtIndex:0];
                NSString *interestTwo = [self.interestsArray objectAtIndex:1];
                self.topInterestsLabel.text = [NSString stringWithFormat:@"Top Interests: %@, %@", interestOne, interestTwo];
            }
            else if (self.interestsArray.count == 1)
            {
                self.topInterestsLabel.text = [NSString stringWithFormat:@"Top Interests: %@", interestString];
            }
            
        }
        
    }
    
    
}

#pragma mark - UICOLLECTIONVIEW
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"profileCell" forIndexPath:indexPath];
    NSString *urlJPG = [self.pageImages objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:urlJPG];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        cell.imageView.image = [UIImage imageWithData:data];
    }];
    
    int pages = floor(self.collectionView.contentSize.width / self.collectionView.frame.size.width);
    [self.pageControl setNumberOfPages:pages];

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pageImages.count;
    
}

#pragma mark - UISCROLLVIEWDELEGATE FOR UIPAGECONTROL


// This method updates the page control status each time I scroll to a new pic.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int pageNumber = roundf(self.collectionView.contentOffset.x/self.collectionView.frame.size.width);
    self.pageControl.currentPage = pageNumber;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int pageNumber = roundf(self.collectionView.contentOffset.x/self.collectionView.frame.size.width);
    self.pageControl.currentPage = pageNumber;
}

@end
