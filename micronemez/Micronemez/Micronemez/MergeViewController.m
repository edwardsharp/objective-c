//
//  MergeViewController.m
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import "MergeViewController.h"

@interface MergeViewController ()

@end

@implementation MergeViewController

@synthesize firstAsset, secondAsset, audioAsset;
@synthesize activityView;

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
    [activityView stopAnimating];
    //[activityView setHidden:YES];
    
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAssetA:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"No saved video found! (record some first?)"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self.loadAssetA setTitle:@"ERROR!" forState:UIControlStateNormal];
      
        
    } else {
        isSelectingAssetA = TRUE;
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
}

- (IBAction)loadAssetB:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
        [self.loadAssetB setTitle:@"ERROR!" forState:UIControlStateNormal];
    } else {
        isSelectingAssetA = FALSE;
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
}

-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id)delegate {
    // 1 - Validation
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Create image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // grab media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // goaway image picker
    [self dismissModalViewControllerAnimated:NO];
    // whatgetzselected voodoo
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        if (isSelectingAssetA){
            NSLog(@"Video A Loaded");
            [self.loadAssetA setTitle:@"LOADED" forState:UIControlStateNormal];
            firstAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        } else {
            NSLog(@"Video B Loaded");
            [self.loadAssetB setTitle:@"LOADED" forState:UIControlStateNormal];
            secondAsset = [AVAsset assetWithURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        }
    }
}

- (IBAction)loadAudio:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAny];
    mediaPicker.delegate = self;
    mediaPicker.prompt = @"Select Audio";
    [self presentModalViewController:mediaPicker animated:YES];
}
//audio callbackz
-(void) mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    NSArray *selectedSong = [mediaItemCollection items];
    if ([selectedSong count] > 0) {
        MPMediaItem *songItem = [selectedSong objectAtIndex:0];
        NSURL *songURL = [songItem valueForProperty:MPMediaItemPropertyAssetURL];
        audioAsset = [AVAsset assetWithURL:songURL];
        NSLog(@"Audio Loaded");
        [self.loadAudio setTitle:@"LOADED" forState:UIControlStateNormal];
    }
    [self dismissModalViewControllerAnimated:YES];
}
// cancel audio callback
-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [self dismissModalViewControllerAnimated: YES];
}

- (IBAction)mergeAndSave:(id)sender {
 
    // now letz do the magic!
    if (firstAsset !=nil && secondAsset!=nil) {
        [self.mergeAndSave setTitle:@"" forState:UIControlStateNormal];
        [activityView startAnimating];
        //disable the back button on navigation controller
        self.navigationItem.hidesBackButton = YES;
        // create AVMutableComposition object that holdz AVMutableCompositionTrack instances.
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        // grab the first track
        AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                            preferredTrackID:kCMPersistentTrackID_Invalid];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration)
                            ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, secondAsset.duration)
                            ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:firstAsset.duration error:nil];
        
        // audio
        if (audioAsset!=nil){
            AVMutableCompositionTrack *AudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
            [AudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration))
                                ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        }
        // setup us up the path...
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"micronemez-%d.mov",arc4random() % 1000]];
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
        // init & run exporter
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetHighestQuality];
        exporter.outputURL=url;
        exporter.outputFileType = AVFileTypeQuickTimeMovie;
        exporter.shouldOptimizeForNetworkUse = YES;
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self exportDidFinish:exporter];
            });
        }];
    }
}

-(void)exportDidFinish:(AVAssetExportSession*)session {
    
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:^(NSURL *assetURL, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        [self.mergeAndSave setTitle:@"ERROR!" forState:UIControlStateNormal];
                    } else {
                        [self.mergeAndSave setTitle:@"SAVED" forState:UIControlStateHighlighted];
                        [self.loadAssetA setHighlighted:YES];
                        [self.loadAssetB setHighlighted:YES];
                        [self.loadAudio setHighlighted:YES];
                        [self.mergeAndSave setHighlighted:YES];
                        self.navigationItem.hidesBackButton = NO;
                    }
                });
            }];
        }
    }
    [activityView stopAnimating];
    //garbage collection
    audioAsset = nil;
    firstAsset = nil;
    secondAsset = nil;
    
}


- (void)viewDidUnload {
    [self setLoadAssetA:nil];
    [self setLoadAssetB:nil];
    [self setLoadAudio:nil];
    [self setMergeAndSave:nil];
    [super viewDidUnload];
}
@end
