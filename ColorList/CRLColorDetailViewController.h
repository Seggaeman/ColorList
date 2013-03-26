//
//  CRLColorDetailViewController.h
//  ColorList
//
//  Created by HDM Ltd on 3/26/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRLColors.h"

@interface CRLColorDetailViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIView* colorView;
@property (weak,nonatomic) IBOutlet UILabel* colorViewLabel;
@property (weak,nonatomic) IBOutlet UILabel* titleLabel;
@property (weak,nonatomic) IBOutlet UILabel* descriptionLabel;
@property (strong, nonatomic) CRLColors* colorInstance;

@end
