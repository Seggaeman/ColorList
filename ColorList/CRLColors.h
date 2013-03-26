//
//  CRLColors.h
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRLColors : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* description;

-(id)initWithTitle:(NSString*)theTitle AndDescription:(NSString*)theDescription;
@end
