//
//  CRLColors.m
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLColors.h"

@implementation CRLColors

-(id)initWithTitle:(NSString *)theTitle AndDescription:(NSString *)theDescription
{
    if (self= [super init])
    {
        self->_title = theTitle;
        self->_description = theDescription;
    }
    return self;
}
@end
