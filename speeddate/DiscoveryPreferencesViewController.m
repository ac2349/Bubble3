//
//  DiscoveryPreferencesViewController.m
//  speeddate
//
//  Created by May Yang on 3/6/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "DiscoveryPreferencesViewController.h"
#import "SWRevealViewController.h"
#import "NMRangeSlider.h"

@interface DiscoveryPreferencesViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *minAge;
@property (weak, nonatomic) IBOutlet UILabel *maxAge;
@property (weak, nonatomic) IBOutlet NMRangeSlider *ageSlider;



@end

@implementation DiscoveryPreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController)
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
    }
    
    [self configureSliders];
    
}

- (IBAction)onDoneButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
// #TODO: Save data.
    // 1) Remember settings within app.
    // 2) Save to phone (NSUserDefaults/Persistence).
    
}

-(void)configureSliders
{
    // Distance slider code
    self.distanceSlider.minimumValue = 1;
    self.distanceSlider.maximumValue = 50;
    self.distanceSlider.continuous = YES;
    self.distanceSlider.value = 50;
    
    
    // Age slider code
    self.ageSlider.minimumValue = 18;
    self.ageSlider.maximumValue = 100;

    self.ageSlider.lowerValue = 18;
    self.ageSlider.upperValue = 100;
    
    self.ageSlider.minimumRange = 1;
    
}

- (IBAction)distanceSliderValueChanged:(UISlider *)sender
{
    int rounded = sender.value;
    [sender setValue:rounded animated:NO];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:sender.value];
    [formatter setMinimumFractionDigits:0];
    
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithFloat:sender.value]];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%@mi.", result];
}


- (IBAction)ageSliderValueChanged:(NMRangeSlider *)sender
{
    [self updateSliderLabels];
}

- (void)updateSliderLabels
{
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.ageSlider.lowerCenter.x + self.ageSlider.frame.origin.x);
    lowerCenter.y = (self.ageSlider.center.y - 30.0f);
    self.minAge.center = lowerCenter;
    self.minAge.text = [NSString stringWithFormat:@"%d", (int)self.ageSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.ageSlider.upperCenter.x + self.ageSlider.frame.origin.x);
    upperCenter.y = (self.ageSlider.center.y - 30.0f);
    self.maxAge.center = upperCenter;
    self.maxAge.text = [NSString stringWithFormat:@"%d", (int)self.ageSlider.upperValue];
}
@end
