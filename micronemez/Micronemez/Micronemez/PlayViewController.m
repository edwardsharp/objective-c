//
//  PlayViewController.m
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

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

- (IBAction)playVideo:(id)sender {
    [self startMediaBrowserFromViewController:self  usingDelegate:self];
}

-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate {
    // first off validation checkz
    if(([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
    || (delegate == nil)
    || (controller == nil)) {
        return NO;
    }
    
    // now letz get the image picker
    UIImagePickerController *mediaID = [[UIImagePickerController alloc] init];

    mediaID.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaID.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    mediaID.allowsEditing = YES;
    mediaID.delegate = delegate;
    
    // show image picker UI
    [controller presentModalViewController:mediaID animated:YES];
    return YES;
}

//choose callback delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //grab the media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //dismiss image picker (if up)
    [self dismissModalViewControllerAnimated:NO];
    //handle movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
                                                 initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        [self presentMoviePlayerViewControllerAnimated:theMovie];
        // register the playback finished callback
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mcrnmzMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];

    }
}

// movie is done, release the controller.
-(void)mcrnmzMovieFinishedCallback:(NSNotification*)aNotification {
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController* theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
}

// is this necessary? 
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated: YES];
}

@end
