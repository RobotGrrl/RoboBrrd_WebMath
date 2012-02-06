//
//  ViewController.h
//  RoboBrrd_WebMath
//
//  Created by Erin Kennedy on 12-02-04.
//  Copyright (c) 2012 robotgrrl.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RscMgr.h"

#define BUFFER_LEN 1024

@interface ViewController : UIViewController <UIWebViewDelegate, RscMgrDelegate> {
    
    // Redpark SDK
    RscMgr *manager;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    // View
    IBOutlet UIWebView *webView;
    IBOutlet UITextView *logView;
    IBOutlet UIImageView *connectedIndicator;
    IBOutlet UIView *debugView;
    
    // Misc
    NSString *gameURL;
    
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UITextView *logView;
@property (nonatomic, retain) IBOutlet UIImageView *connectedIndicator;
@property (nonatomic, retain) NSString *gameURL;

- (void) sendAction:(int)a command:(int)c;
- (void) logThis:(NSString *)s;
- (void) refreshURL;

- (IBAction) test1:(id)sender;
- (IBAction) test2:(id)sender;
- (IBAction) refreshPage:(id)sender;
- (IBAction) memoryGame:(id)sender;
- (IBAction) mathGame:(id)sender;
- (IBAction) sneakyView:(id)sender;

- (void) leftWing;
- (void) rightWing;
- (void) openBeak;
- (void) closeBeak;
- (void) shake;
- (void) eyes;
- (void) victory;
- (void) match;
- (void) wrong;

@end
