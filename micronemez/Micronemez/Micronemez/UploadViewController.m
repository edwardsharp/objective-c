//
//  UploadViewController.m
//  Micronemez
//
//  Created by edward on 12/31/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import "UploadViewController.h"
#import "ASIHTTPRequest/ASIHTTPRequest.h"
#import "ASIHTTPRequest/ASINetworkQueue.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectUpload:(id)sender {
    [self startMediaBrowserFromUploadViewController:self  usingDelegate:self];
}

-(BOOL)startMediaBrowserFromUploadViewController:(UIViewController *)controller usingDelegate:(id)delegate {
    // first off validation checkz
    if(([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
       || (delegate == nil)
       || (controller == nil)) {
        return NO;
    }
    
    // now letz get the image picker
    UIImagePickerController *uploadMediaID = [[UIImagePickerController alloc] init];
    
    uploadMediaID.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    uploadMediaID.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    uploadMediaID.allowsEditing = YES;
    uploadMediaID.delegate = delegate;
    
    // show image picker UI
    [controller presentModalViewController:uploadMediaID animated:YES];
    return YES;
}

//choose callback delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //grab the media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //dismiss image picker (if up)
    [self dismissModalViewControllerAnimated:NO];
    //the pick:  [info objectForKey:UIImagePickerControllerMediaURL]
    //TODO: upload this sucka!
    //TODO: enable cancel button
    [self doNetworkOperations];
}

// is this necessary?
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated: YES];
}


- (void)doNetworkOperations
{
	// Stop anything already in the queue before removing it
	[[self networkQueue] cancelAllOperations];
	
	// Creating a new queue each time we use it means we don't have to worry about clearing delegates or resetting progress tracking
	[self setNetworkQueue:[ASINetworkQueue queue]];
	[[self networkQueue] setDelegate:self];
	[[self networkQueue] setRequestDidFinishSelector:@selector(requestFinished:)];
	[[self networkQueue] setRequestDidFailSelector:@selector(requestFailed:)];
	[[self networkQueue] setQueueDidFinishSelector:@selector(queueFinished:)];
    
	int i;
	for (i=0; i<5; i++) {
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.122:3000"]];
		[[self networkQueue] addOperation:request];
	}
    
	[[self networkQueue] go];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	// You could release the queue here if you wanted
	if ([[self networkQueue] requestsCount] == 0) {
        
		// Since this is a retained property, setting it to nil will release it
		// This is the safest way to handle releasing things - most of the time you only ever need to release in your accessors
		// And if you an Objective-C 2.0 property for the queue (as in this example) the accessor is generated automatically for you
		[self setNetworkQueue:nil];
	}
	
	//... Handle success
	NSLog(@"Request finished");
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	// You could release the queue here if you wanted
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
	
	//... Handle failure
	NSLog(@"Request failed");
}


- (void)queueFinished:(ASINetworkQueue *)queue
{
	// You could release the queue here if you wanted
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
	NSLog(@"Queue finished");
}

@synthesize networkQueue;



@end
