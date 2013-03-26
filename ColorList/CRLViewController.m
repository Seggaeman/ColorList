//
//  CRLViewController.m
//  ColorList
//
//  Created by HDM Ltd on 3/25/13.
//  Copyright (c) 2013 HDM Ltd. All rights reserved.
//

#import "CRLViewController.h"
#import "CRLURLHelper.h"
#import "CRLColors.h"
#import "TitleDescriptionCell.h"
#import "UIColor+HexString.h"

#define networkNotificationActivityOn()  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]
#define networkNotificationActivityOff() [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]

@interface CRLViewController ()

@end

@implementation CRLViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self->theData = [NSMutableData data];
        self->colors = [NSMutableArray array];
        [self.tableView registerNib:[UINib nibWithNibName:@"TitleDescriptionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TitleDescriptionCell"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidUnload
{
    
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self->theData setLength:0];
    [self->colors removeAllObjects];
    //[self->theData setData:nil]; should work too
    //NSMutableDictionary* getDictionary = [@{@"format":@"json"} mutableCopy];
    [CRLURLHelper HTTPRequest:[NSURL URLWithString:@"http://colourlovers.com/api/colors?format=json"] requestMethod:@"GET" requestData:nil URLConnectionDataDelegate:self];
    networkNotificationActivityOn();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];    
}

#pragma mark - NSURLDataDelegate methods
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"Response received");
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"Receiving data");
    [self->theData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* theError= [[NSError alloc] init];
    NSMutableArray* jsonArray= [NSJSONSerialization JSONObjectWithData:self->theData options:NSJSONReadingMutableContainers error:&theError];
    [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary* jsonDict= (NSMutableDictionary*)obj;
        CRLColors* colorInst= [[CRLColors alloc] initWithDictionary:jsonDict];
        [self->colors addObject:colorInst];
    }];
    networkNotificationActivityOff();
    [self.tableView reloadData];
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"Failed");
    UIAlertView* errorView= [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Erreur en accedant le URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorView show];
    
}

#pragma mark- UITableView methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self->colors count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleDescriptionCell* theCell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleDescriptionCell"];
    
    //retrieve color model instance
    CRLColors* colorInst= [self->colors objectAtIndex:indexPath.row];

    //set title and description
    [theCell.titleLabel setText:colorInst.title];
    [theCell.descriptionLabel setText:colorInst.description];
    //NSLog(@"%@", colorInst.colorString);
    [theCell.colorView setBackgroundColor:[UIColor colorWithHexString:colorInst.colorString]];
    return theCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
@end
