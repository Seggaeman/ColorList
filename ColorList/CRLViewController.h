//
//  CRLViewController.h
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRLViewController : UITableViewController <NSURLConnectionDataDelegate>
{
    NSMutableData* theData;
    NSMutableArray* colors;
}
@end
