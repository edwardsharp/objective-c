//
//  MergeViewController.h
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>


@interface MergeViewController : UIViewController {
    BOOL isSelectingAssetA;
}

@property(nonatomic, strong) AVAsset *firstAsset;
@property(nonatomic, strong) AVAsset *secondAsset;
@property(nonatomic, strong) AVAsset *audioAsset;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)loadAssetA:(id)sender;
- (IBAction)loadAssetB:(id)sender;
- (IBAction)loadAudio:(id)sender;
- (IBAction)mergeAndSave:(id)sender;
-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id)delegate;
-(void)exportDidFinish:(AVAssetExportSession*)session;


@end
