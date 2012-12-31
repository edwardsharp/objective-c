//
//  RecordViewController.m
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

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

- (IBAction)recordAndPlay:(id)sender {
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
usingDelegate:(id )delegate {
    // validation and null checkz
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // image picker
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // hide controls for moving & scaling pictures, or editing
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    // show image picker
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:NO];
    // movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,
                                                @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"ohnoz! Can't save that?!"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SAVED IT!" message:@"Saved to Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


@end
