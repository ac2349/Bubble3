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
#import "MainViewController.h"

@interface DiscoveryPreferencesViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *minAge;
@property (weak, nonatomic) IBOutlet UILabel *maxAge;
@property (weak, nonatomic) IBOutlet NMRangeSlider *ageSlider;
@property NSMutableArray *discoverySettings;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentedControl;
@property NSString *selectedSex;



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
    
    self.discoverySettings = [NSMutableArray new];
}


- (IBAction)segmentedControlAction:(UISegmentedControl *)sender
{
    if (self.sexSegmentedControl.selectedSegmentIndex == 0)
    {
        self.selectedSex = @"male";
        NSLog(@"%@", self.selectedSex);
    }
    else if (self.sexSegmentedControl.selectedSegmentIndex == 1)
    {
        self.selectedSex = @"female";
        NSLog(@"%@", self.selectedSex);
    }
    else
    {
        self.selectedSex = @"both";
        NSLog(@"%@", self.selectedSex);
    }
    
}


#pragma mark - UISLIDER CODE

-(void)configureSliders
{
    // Distance slider code
    self.distanceSlider.minimumValue = 1;
    self.distanceSlider.maximumValue = 50;
    self.distanceSlider.continuous = YES;
    self.distanceSlider.value = 50;
    
    
    // Age slider code
    self.ageSlider.minimumValue = 18;
    self.ageSlider.maximumValue = 99;

    self.ageSlider.upperValue = 99;
    self.ageSlider.lowerValue = 18;
    
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
    
    self.distanceLabel.text = result;
}


- (IBAction)ageSliderValueChanged:(NMRangeSlider *)sender
{
    [self updateSliderLabels];
}

- (void)updateSliderLabels
{
    self.minAge.text = [NSString stringWithFormat:@"%d", (int)self.ageSlider.lowerValue];
    
    self.maxAge.text = [NSString stringWithFormat:@"%d", (int)self.ageSlider.upperValue];
}


#pragma mark - SEGUE

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.discoverySettings addObject:self.distanceLabel.text];
    [self.discoverySettings addObject:[NSNumber numberWithInt:self.ageSlider.lowerValue]];
    [self.discoverySettings addObject:[NSNumber numberWithInt:self.ageSlider.upperValue]];
    
// TODO:  fix bug for nil object
    [self.discoverySettings addObject:self.selectedSex];
    
    if ([segue.identifier   isEqualToString:@"discoverySettingsSegue"])
    {
        MainViewController *vc = segue.destinationViewController;
        vc.discoverySettingsArray = self.discoverySettings;
    }
    
}


@end
