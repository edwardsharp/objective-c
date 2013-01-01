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
#import "ASIHTTPRequest/CloudFiles/ASICloudFilesRequest.h"
#import "ASIHTTPRequest/CloudFiles/ASICloudFilesObjectRequest.h"


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
    
	//kindof handy to drill down into a gallery (saves 1 touch)? 
	// dunno what happenz if therez more than one user gallery?
    //uploadMediaID.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    uploadMediaID.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //filter for just videoz
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
    
    //dismiss image picker (if up)
    [self dismissModalViewControllerAnimated:NO];
    
    //disable the back button on navigation controller
    self.navigationItem.hidesBackButton = YES;
    
    //disable selectUpload
    self.selectUpload.enabled = NO;
    
    //turn on the spinner
    [self.uploadActivityIndicator startAnimating];
    
    //the pick:  [info objectForKey:UIImagePickerControllerMediaURL]
    //TODO: upload this sucka!
    //TODO: enable cancel button
    
    // STOP IT!  ABOUT TO USE ASI QUEUE
	[[self networkQueue] cancelAllOperations];
	
	// Creating a new queue each time we use it means we don't have to worry about clearing delegates or resetting progress tracking, yay!
	[self setNetworkQueue:[ASINetworkQueue queue]];
	[[self networkQueue] setDelegate:self];
	[[self networkQueue] setRequestDidFinishSelector:@selector(requestFinished:)];
	[[self networkQueue] setRequestDidFailSelector:@selector(requestFailed:)];
	[[self networkQueue] setQueueDidFinishSelector:@selector(queueFinished:)];
    
    //TODO: move this outta here:
    [ASICloudFilesRequest setUsername:@"username"];
    [ASICloudFilesRequest setApiKey:@"put-your-api-key-here"];
    [ASICloudFilesRequest authenticate];
    
    //[info objectForKey:UIImagePickerControllerMediaURL];
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSLog(mediaType);
    
    NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSString *urlString=[urlvideo path];
    NSString *fileNameString=[urlvideo lastPathComponent];
    
    NSLog(@"urlString: %@",urlString);
	
	//dream
	//MSString *fileExtString = [urlvideo extensionPathComponent];

    // path to a file, and no mime type, detect it from the file extension?
	//#TODO: deal with contentType
    //NSString *contentType = [ASIHTTPRequest mimeTypeForFileAtPath:urlString];
    NSString *contentType = @"video/quicktime";
    NSLog(@"contentType: %@", contentType);
    
    ASICloudFilesObjectRequest *request =
    [ASICloudFilesObjectRequest putObjectRequestWithContainer:@"some-container" objectPath:fileNameString contentType:contentType file:urlString  metadata:nil etag:nil];
    
    //yeah network queuez!
    [[self networkQueue] addOperation:request];
     
	[[self networkQueue] go];

}

// is this necessary?
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated: YES];
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
        self.navigationItem.hidesBackButton = NO;
        self.selectUpload.enabled = YES;
        [self.uploadActivityIndicator stopAnimating];
		[self setNetworkQueue:nil];
	}
	NSLog(@"Queue finished");
}

@synthesize networkQueue;


- (void)viewDidUnload {
    [self setSelectUpload:nil];
    [self setUploadActivityIndicator:nil];
    [self setSelectUpload:nil];
    [super viewDidUnload];
}
@end
