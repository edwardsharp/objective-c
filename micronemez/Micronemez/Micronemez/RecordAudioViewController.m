//
//  RecordAudioViewController.m
//  Micronemez
//
//  Created by edward on 12/30/12.
//  Copyright (c) 2012 futuredeathtoll. All rights reserved.
//

#import "RecordAudioViewController.h"

#define XMAX	20.0f

@interface RecordAudioViewController ()

@end

@implementation RecordAudioViewController

@synthesize
    SoundPath,
    soundRecorder,
    audioPlayer,
    playLoopSlider,
    playLoopLabel,
    recordTimer,
    recordMeter,
    audioActionHeaderButton;

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
	// set us up the sound recorder!
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir =[paths objectAtIndex:0];
    
//    NSDateFormatter *formatter;
//    NSString        *dateString;
//    formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"ddMMyyyyHHmm"];
//    dateString = [formatter stringFromDate:[NSDate date]];
//    NSString *dateStamp = [documentsDir stringByAppendingPathComponent:dateString];
    
    NSString *soundFilePath =[documentsDir stringByAppendingPathComponent:@"micronemez.mp4"];
    NSLog(@"SOUNDFILEPATH: %@", soundFilePath);
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    self.SoundPath=newURL;
    recording = NO;
    playing = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    recordButton = nil;
    playOrRecordButton = nil;
    [self setPlayLoopSlider:nil];
    [self setPlayLoopLabel:nil];
    [self setRecordMeter:nil];
    [self setAudioActionHeaderButton:nil];
    [super viewDidUnload];
}
- (IBAction)recordOrStop:(id)sender {
    
    if (recording) {
        [soundRecorder stop];
        recording = NO;
        self.soundRecorder = nil;
        
        if( recordTimer != nil ){
            [recordTimer invalidate];
            recordTimer = nil;
        }
        
        [recordButton setTitle: @"RECORD" forState:UIControlStateNormal];
        [recordButton setTitle: @"RECORD" forState:UIControlStateHighlighted];
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        //[[AVAudioSession sharedInstance] setActive: YES error: nil];
        [recordMeter setHidden: YES];
    } else {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        //kAudioFormatMPEG4AAC
        //kAudioFormatAppleLossless
        NSDictionary *recordSettings =[[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                       [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                       [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                       
                                       [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey, nil];
        AVAudioRecorder *newRecorder =[[AVAudioRecorder alloc] initWithURL: SoundPath settings: recordSettings error: nil];
        self.soundRecorder = newRecorder;
        soundRecorder.delegate = self;
        [soundRecorder prepareToRecord];
        soundRecorder.meteringEnabled = YES;
        [soundRecorder record];
        
        //update the the meters
       recordTimer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                                target:self selector:@selector(meterTimerTask) userInfo:nil repeats:YES];
        [recordMeter setHidden: NO];
        [recordButton setTitle: @"STOP" forState: UIControlStateNormal];
        [recordButton setTitle: @"STOP" forState: UIControlStateHighlighted];
        recording = YES;
    }
}

- (IBAction)playOrStop:(id)sender {
    NSError *error;
    //NSLog(@"PLAYORSTOP  SOUNDFILEPATH: %@", self.SoundPath);
    //AVAudioPlayer *player =[[AVAudioPlayer alloc] initWithContentsOfURL:self.SoundPath error:&error];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.SoundPath error:&error];
    
    audioPlayer.delegate = self;
    audioPlayer.volume = 1.0;
    audioPlayer.numberOfLoops = [[NSNumber numberWithFloat:playLoopSlider.value] intValue];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    }
    if(playing){
        [audioPlayer stop];
        playing = NO;
        [playOrRecordButton setTitle: @"PLAY" forState:UIControlStateNormal];
        [playOrRecordButton setTitle: @"PLAY" forState:UIControlStateHighlighted];
        [playLoopSlider setEnabled:YES];
    } else {
        [audioPlayer prepareToPlay];
//        [self performSelector:@selector(playTheAudio) withObject:player afterDelay:3.0];
//        NSLog(@"ABOUT TO PLAY: %@", audioPlayer.settings);
        [audioPlayer play];
        playing = YES;
        [playOrRecordButton setTitle: @"STOP" forState:UIControlStateNormal];
        [playOrRecordButton setTitle: @"STOP" forState:UIControlStateHighlighted];
        [playLoopSlider setEnabled:NO];
    }

}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [playOrRecordButton setTitle: @"PLAY" forState:UIControlStateNormal];
    [playOrRecordButton setTitle: @"PLAY" forState:UIControlStateHighlighted];
    playing = NO;
    [playLoopSlider setEnabled:YES];
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"success");
}
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"fail");
}

-(IBAction) sliderValueChanged:(UISlider *)sender {
    playLoopLabel.text = [NSString stringWithFormat:@"%i", [[NSNumber numberWithFloat:playLoopSlider.value] intValue]];
}

- (void)meterTimerTask {
    [soundRecorder updateMeters];
    //float level = [soundRecorder peakPowerForChannel:0];
    float avg = [soundRecorder averagePowerForChannel:0];

    
    NSLog(@"%f", avg);
    [recordMeter setProgress:(XMAX + avg) / XMAX];
}

@end
