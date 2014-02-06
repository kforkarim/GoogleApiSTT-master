//
//  STTController.h
//  WhiteLabelCartCheckout
//
//  Created by Abdul, Karim (Contractor) on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "STTModel.h"

/** 
 A STTControllerDelegate delegate protocol set for this class.
 */
@protocol STTControllerDelegate
@optional

/** 
 audioRecordingCompleted Method is optional method when used the delegate, which passes the LocatorView.
 @param convertedSTT Speech to text is being passed in form of a dictionary when converion is completed.
 */ 
- (void)audioConvertedToText:(NSDictionary*)audioResponse;

- (void)speechToTextCompletion:(NSURLResponse*)response
                          data:(NSData*)data
                         error:(NSError*)error;

@end

/** 
 A STTController class regulates the control of audio recoding.
 Conforms the AVAudioRecorderDelegate and STTControllerDelegate
 */
@interface STTController : NSObject <AVAudioRecorderDelegate, STTModelDelegate> {

    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *audioRecorder;
    int recordEncoding;
}

@property (weak,nonatomic) id <STTControllerDelegate> STTControllerdelegate;

/**
 audioRecorder Property set to record audio.
 */
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;


/** 
 init method sets the delegation
 */

- (id)init;

/** 
 startRecording method starts audio recording.
 */
- (void)startRecording;

/** 
 stopRecording method stops audio recording.
 */
- (void)stopRecording;

/** 
 playRecording method play audio recording.
 */
- (void)playRecording;

/** 
 stopPlaying method stops playing audio.
 */
- (void)stopPlaying;

@end
