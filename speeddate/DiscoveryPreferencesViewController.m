//
//  DiscoveryPreferencesViewController.m
//  speeddate
//
//  Created by May Yang on 3/6/15.
//  Copyright (c) 2015 Studio76. All rights reserved.
//

#import "DiscoveryPreferencesViewController.h"
#import "SWRevealViewController.h"

@interface DiscoveryPreferencesViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

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
    
    // Distance slider code
    self.distanceSlider.minimumValue = 1;
    self.distanceSlider.maximumValue = 50;
    self.distanceSlider.continuous = YES;
    self.distanceSlider.value = 50;
    
}

- (IBAction)onDoneButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
// #TODO: Save data.
    // 1) Remember settings within app.
    // 2) Save to phone (NSUserDefaults/Persistence).
    
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

@end
