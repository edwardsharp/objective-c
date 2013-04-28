//
//  RecordAudioViewController.h
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordAudioViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    NSURL *SoundPath;
    bool recording;
    bool playing;
    bool paused;
    AVAudioRecorder *soundRecorder;
    AVAudioPlayer *audioPlayer;
    __weak IBOutlet UIButton *recordButton;
    __weak IBOutlet UIButton *playOrRecordButton;
}
@property(nonatomic,retain) NSURL *SoundPath;
@property(nonatomic,retain) AVAudioRecorder *soundRecorder;
@property(nonatomic, retain) AVAudioPlayer *audioPlayer;
@property(weak, nonatomic) NSTimer *recordTimer;

- (IBAction)recordOrStop:(id)sender;
- (IBAction)playOrStop:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *playLoopSlider;
@property (weak, nonatomic) IBOutlet UILabel *playLoopLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *recordMeter;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *audioActionHeaderButton;


@end
