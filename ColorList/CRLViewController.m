//
//  CRLViewController.m
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLViewController.h"
#import "CRLURLHelper.h"

@interface CRLViewController ()

@end

@implementation CRLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self->theData = [NSMutableData data];
}

-(void)viewDidUnload
{
    
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self->theData setLength:0];
    //[self->theData setData:nil]; should work too
    //NSMutableDictionary* getDictionary = [@{@"format":@"json"} mutableCopy];
    [CRLURLHelper HTTPRequest:[NSURL URLWithString:@"http://colourlovers.com/api/colors?format=json"] requestMethod:@"GET" requestData:nil URLConnectionDataDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLDataDelegate methods
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Response received");
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receiving data");
    [self->theData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@", [[NSString alloc] initWithData:self->theData encoding:NSUTF8StringEncoding]);
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Failed");
}
@end
