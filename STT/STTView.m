//
//  TTSView.m
//  WhiteLabelCartCheckout
//
//  Created by Abdul, Karim (Contractor) on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "STTView.h"

@interface STTView ()

//Private Properties
@property (nonatomic, strong) STTController *sttController;
@property (nonatomic, strong) UIButton *stopPlayerButton;
@property (nonatomic, strong) UIButton *stopRecordingButton;
@property (nonatomic, strong) UIButton *startPlayerButton;
@property (nonatomic, strong) UIButton *startRecordingButton;
//@property (nonatomic, strong) UIButton *micButton;

//Private Methods
- (void) micPressed:(id)sender;
- (void) stopPlayingButtonPressed;
- (void) stopRecordingButtonPressed;
- (void) startPlayingButtonPressed;
- (void) startRecordingButtonPressed;

@end

@implementation STTView

@synthesize sttController, stopPlayerButton, stopRecordingButton, startPlayerButton, startRecordingButton, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] pathForResource:@"mic_icon-black" ofType:@"png"]]];
        
        //[image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [self setUserInteractionEnabled:YES];
        [self setTag:103];
        [self addTarget:self action:@selector(micPressed:)forControlEvents:UIControlEventTouchDown];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        
        //Set the state of the mic Button
        [self setSelected:![self isSelected]];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        
        //Set Delegate
        self.delegate = self;
        
        NSLog(@"%f, %f, %f, %f",frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        NSLog(@"%f, %f, %f, %f",self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
        //Initialize STTController
        self.sttController = [[STTController alloc] init];
        self.sttController.STTControllerdelegate = self;

    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    
//}

- (void) micPressed:(id)sender {
    
    if ([sender isKindOfClass:[UIButton class]]) {
        NSLog(@"test");
        if ([self isSelected]) {
            NSLog(@"selected");
            [self startRecordingButtonPressed];
            //Toggle between Selections
            [self setSelected:![self isSelected]];
            
            UIImage *redImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] pathForResource:@"mic_icon-red" ofType:@"png"]]];
            
            [self setImage:redImage forState:UIControlStateNormal];
             NSLog(@"%f, %f, %f, %f",self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            
        }
        
        else {
            NSLog(@"deselected");
            [self stopRecordingButtonPressed];
            //Toggle between Selections
            [self setSelected:![self isSelected]];
            
            UIImage *blackImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] pathForResource:@"mic_icon-black" ofType:@"png"]]];
            
            [self setImage:blackImage forState:UIControlStateNormal];
            
        }
    }
    
}

- (void) stopPlayingButtonPressed {
    
    NSLog(@"reached stop playing button method");
    
    [self.sttController stopPlaying];
}


- (void) stopRecordingButtonPressed {
    
    NSLog(@"reached stop playing button method");
    
    [self.sttController stopRecording];

}

- (void) startPlayingButtonPressed {
    
    NSLog(@"reached stop playing button method");
    
    [self.sttController playRecording];

}

- (void) startRecordingButtonPressed {
    
    NSLog(@"reached stop playing button method");
    
    [self.sttController startRecording];
    
}

- (void)audioConvertedToText:(NSDictionary *)audioResponse {
    
    [delegate aRCompleted:audioResponse];
}


- (void)speechToTextCompletion:(NSURLResponse*)response
                          data:(NSData*)data
                         error:(NSError*)error
{
    
    [delegate speechToTextCompletion:response data:data error:error];
}


@end
