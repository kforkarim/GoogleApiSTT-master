//
//  testViewController.h
//  GoogleApiSTT
//
//  Created by Karim Abdul on 8/20/13.
//  Copyright (c) 2013 Karim Abdul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTView.h"

@interface testViewController : UIViewController <STTDelegate,STTModelDelegate>

@property (nonatomic, strong) STTView *sttView;
@property (nonatomic, strong) STTModel *sttModel;

- (IBAction)startRecordingAudio:(id)sender;
- (IBAction)stopRecordingAudio:(id)sender;
- (IBAction)playAudio:(id)sender;

@end
