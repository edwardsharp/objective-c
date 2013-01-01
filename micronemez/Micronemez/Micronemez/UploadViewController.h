//
//  UploadViewController.h
//  Micronemez
//
//  Created by edward on 12/31/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
@class ASINetworkQueue;

@interface UploadViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    ASINetworkQueue *networkQueue;
}
- (IBAction)selectUpload:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectUpload;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *uploadActivityIndicator;
- (BOOL)startMediaBrowserFromUploadViewController:(UIViewController*)controller usingDelegate:(id )delegate;
//- (void)doNetworkOperations;

@property (retain) ASINetworkQueue *networkQueue;


@end
