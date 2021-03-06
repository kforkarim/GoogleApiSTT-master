//
//  TTSView.h
//  WhiteLabelCartCheckout
//
//  Created by Abdul, Karim (Contractor) on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTController.h"

/** 
 A STTDelegate delegate protocol set for STTView class.
 */
@protocol STTDelegate
@optional

/** 
 aRCompleted Method being used when audio recoding got completed. 
 @param convertedSTT Speech to text is being passed in form of a dictionary when converion is completed.
 */ 
- (void)aRCompleted:(NSDictionary*)convertedSTT;

- (void)speechToTextCompletion:(NSURLResponse*)response
                          data:(NSData*)data
                         error:(NSError*)error;

@end


/** 
 STTView ChildView of UIButton. When the button is being pressed, on feature will change the state of the icon image of button, when changed to off, aRCompleted delegate will dispatch with prompt result of the audio in text format.
 Conforms the STTDelegate, and STTControllerDelegate 
 */
@interface STTView : UIButton <STTDelegate,STTControllerDelegate> {
    
    id <STTDelegate> delegate;

}

- (void) stopPlayingButtonPressed;
- (void) stopRecordingButtonPressed;
- (void) startPlayingButtonPressed;
- (void) startRecordingButtonPressed;

/** 
 A STTDelegate delegate property set for STTView class.
 */

@property (strong, nonatomic) id <STTDelegate> delegate;

@end
