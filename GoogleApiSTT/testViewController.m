//
//  testViewController.m
//  GoogleApiSTT
//
//  Created by Karim Abdul on 8/20/13.
//  Copyright (c) 2013 Karim Abdul. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController

@synthesize sttModel, sttView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.sttView = [[STTView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 40.0f, 40.0f)];
    //[self.view addSubview:self.sttView];
	// Do any additional setup after loading the view, typically from a nib.
    self.sttView = [[STTView alloc] init];
    self.sttView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)speechToTextCompletion:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error
{
    
    if (!error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions
                                                               error:&error];
        
        NSString *value = [NSString stringWithFormat:@"%@",[json valueForKey:@"hypotheses"]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"STT" message:value delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
}

- (IBAction)startRecordingAudio:(id)sender {
    
    [self.sttView startRecordingButtonPressed];
}


- (IBAction)stopRecordingAudio:(id)sender {
    
    [self.sttView stopRecordingButtonPressed];
}

- (IBAction)playAudio:(id)sender {
    
    [self.sttView startPlayingButtonPressed];
}

- (BOOL)listen:(NSError **)err {
    
    return YES;
}

@end
