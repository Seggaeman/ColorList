//
//  CRLColorDetailViewController.m
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLColorDetailViewController.h"
#import "UIColor+HexString.h"
@interface CRLColorDetailViewController ()

@end

@implementation CRLColorDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.colorView setBackgroundColor:[UIColor colorWithHexString:self.colorInstance.colorString inverted:NO]];
    [self.colorViewLabel setTextColor:[UIColor colorWithHexString:self.colorInstance.colorString inverted:YES]];
    [self.colorViewLabel setText:[@"#" stringByAppendingString:self.colorInstance.colorString]];
    [self.titleLabel setText:self.colorInstance.title];
    [self.descriptionLabel setText:self.colorInstance.description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
