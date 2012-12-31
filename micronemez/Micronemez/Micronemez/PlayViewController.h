//
//  PlayViewController.h
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)playVideo:(id)sender;

//open this sucka up!
-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;


@end
