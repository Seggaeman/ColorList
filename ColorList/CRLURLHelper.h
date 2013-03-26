//
//  CRLURLHelper.h
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRLURLHelper : NSObject

+(void)HTTPRequest:(NSURL*)theURL requestMethod:(NSString*)theMethod requestData:(NSMutableDictionary*)inputData URLConnectionDataDelegate:(id<NSURLConnectionDataDelegate>)theDelegate;

@end
