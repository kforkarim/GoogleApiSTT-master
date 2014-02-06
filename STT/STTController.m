//
//  STTController.m
//  WhiteLabelCartCheckout
//
//  Created by Abdul, Karim (Contractor) on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STTController.h"
#import "STTModel.h"
#include <stdio.h>

@interface STTController ()

@property (nonatomic, strong) STTModel *sttModel;

@end

@implementation STTController

@synthesize audioRecorder, sttModel, STTControllerdelegate;

- (id)init {
    
    self = [super init]; 
    if (self) {
        //self.STTControllerdelegate = self;
        
        if (!sttModel) {
            self.sttModel = [[STTModel alloc] init];
            self.sttModel.delegate = self;
        }
//        recordEncoding = ENC_PCM;
//        self.audioRecorder.delegate = self;
        
    }
    return self;
}


- (void)startRecording {
    
    NSLog(@"startRecording");
    
    // Init audio with record capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];

    //Setup RecordSetting
    NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey]; 
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey]; 

    //Setup File Names
    NSString *fileName = @"newRecordTest.wav";
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [self.sttModel applicationDocumentDirectory],fileName]];
    NSError *error = nil;
    
    NSLog(@"url %@", url);
    
    
    
    if (!audioRecorder) {
            
        self.audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
        self.audioRecorder.delegate = self;
    }
    
    if ([audioRecorder isRecording]) {
        return;
    }
    
    if ([audioRecorder prepareToRecord] == YES){
        [audioRecorder recordForDuration:10];
        NSLog(@"recording");
    }
    
    else {
        int errorCode = CFSwapInt32HostToBig ([error code]); 
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode); 
        
    }
    
}

- (void)stopRecording {
    
    NSLog(@"stopRecording");
    [audioRecorder stop];
    NSLog(@"stopped");
//    [STTModel convertWaveToFlac:@"newRecordTest.wav" :@"newRecordTest.flac"];
//    [STTModel STTFromGoogle:[NSString stringWithFormat:@"newRecordTest.flac"]];
    
}

- (void)playRecording {
    
    NSLog(@"playRecording");
    // Init audio with playback capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/newRecordTest.wav", [[NSBundle mainBundle] resourcePath]]];
    NSString *fileName = @"newRecordTest.wav";
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [self.sttModel applicationDocumentDirectory],fileName]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];
    NSLog(@"playing");
}

- (void)stopPlaying {
    
    NSLog(@"stopPlaying");
    NSLog(@"%@ folderPath",[self.sttModel applicationDocumentDirectory]);
    [audioPlayer stop];
    NSLog(@"stopped");
    
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {

    NSLog(@"%d",flag);
    if (flag) {
        
        //[STTModel convertWaveToFlac:@"newRecordTest.wav" :@"newRecordTest.flac"];
        [self.sttModel convertWaveToFlac:@"newRecordTest.wav" OutputFileName:@"newRecordTest.flac"];
        [self.sttModel STTFromGoogle:[NSURL URLWithString:@"newRecordTest.flac"]];
        //NSDictionary *conversionCompleted = [STTModel STTFromGoogle:[NSURL URLWithString:@"newRecordTest.flac"]];
        //[STTControllerdelegate audioRecordingCompleted:conversionCompleted];
    }
}

- (void)audioConvertedToTextFromModel:(NSDictionary *)audioResponse {
    
    NSLog(@"%@",audioResponse);
    [self.STTControllerdelegate audioConvertedToText:audioResponse];
}

- (void)speechToTextCompletion:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error
{
    
    [self.STTControllerdelegate speechToTextCompletion:response data:data error:error];
}


@end
