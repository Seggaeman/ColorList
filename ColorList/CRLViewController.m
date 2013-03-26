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
#import "CRLColorDetailViewController.h"

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
    //scrolling before JSON data has been retrieved makes application crash; next line prevents this.
    //commented out because we are checking the object count in self->colors. If it's > 0 don't redownload the JSON.
    //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [super viewDidAppear:animated];
    if ([self->colors count] == 0)
    {
        [self->theData setLength:0];
        [self->colors removeAllObjects];

        [CRLURLHelper HTTPRequest:[NSURL URLWithString:@"http://colourlovers.com/api/colors?format=json"] requestMethod:@"GET" requestData:nil URLConnectionDataDelegate:self];
        networkNotificationActivityOn();
    }
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
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
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
    //[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
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
    [theCell.colorView setBackgroundColor:[UIColor colorWithHexString:colorInst.colorString inverted:NO]];
    return theCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRLColors* colorInst= self->colors[indexPath.row];
    CRLColorDetailViewController* colorDetailVC= [[CRLColorDetailViewController alloc] init];
    colorDetailVC.colorInstance = colorInst;
    
    [self.navigationController pushViewController:colorDetailVC animated:YES];
}
@end
