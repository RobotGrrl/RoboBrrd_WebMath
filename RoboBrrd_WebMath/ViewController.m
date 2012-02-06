//
//  ViewController.m
//  RoboBrrd_WebMath
//
//  Created by Erin Kennedy on 12-02-04.
//  Copyright (c) 2012 robotgrrl.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize webView, logView, connectedIndicator, gameURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameURL = @"http://eduboticsapp.appspot.com";
    
    UIImage *img = [UIImage imageNamed:@"RedLight.png"];
    connectedIndicator.image = img;	
    
    [debugView setHidden:YES];
    
    id scrollview = [[webView subviews] lastObject];
    if ([(UIScrollView *)scrollview respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView *)scrollview setScrollEnabled:NO];
    }
    
    manager = [[RscMgr alloc] init]; 
	[manager setDelegate:self];
    [self logThis:@"manager"];

    [self refreshURL];
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:gameURL]]];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return YES;
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
    */
}

- (IBAction) sneakyView:(id)sender {
    [debugView setHidden:!debugView.hidden];
}

#pragma mark - RscMgrDelegate Methods

- (void) cableConnected:(NSString *)protocol {
    [self logThis:@"conn"];
    [manager setBaud:9600];
	[manager open];
    [self logThis:@"open"];
    UIImage *img = [UIImage imageNamed:@"GreenLight.png"];
    connectedIndicator.image = img;
    
}

- (void) cableDisconnected {
    [self logThis:@"disconn"];
    UIImage *img = [UIImage imageNamed:@"RedLight.png"];
    connectedIndicator.image = img;
}

- (void) portStatusChanged {
    
}

- (void) readBytesAvailable:(UInt32)numBytes {
    [self logThis:@"read bytes"];
}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    return FALSE;    
}

- (void) didReceivePortConfig {
}

- (void) sendAction:(int)a command:(int)c {

    // Send data
    txBuffer[0] = a;
    txBuffer[1] = c;
    int bytesWritten = [manager write:txBuffer Length:2];

    [self logThis:[NSString stringWithFormat:@"wrote bytes: %d", bytesWritten]];

}

#pragma UIWebViewDelegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [self logThis:[NSString stringWithFormat:@"shouldStartLoadWithRequest: %@", request]];
    
    NSString *theURL = [[request URL] absoluteString];
    NSString *urlScheme = [[request URL] scheme];
    
    [self logThis:[NSString stringWithFormat:@"request url scheme: %@", urlScheme]];
        
    if([theURL hasPrefix:@"robo:"]) {
        
        NSString *action = [theURL substringFromIndex:5];
    
        BOOL correct = NO;
        
        [self logThis:action];
        
        if([action isEqualToString:@"leftwing"]) {
            [self leftWing];
            correct = YES;
        } else if([action isEqualToString:@"rightwing"]) {
            [self rightWing];
            correct = YES;
        } else if([action isEqualToString:@"openbeak"]) {
            [self openBeak];
            correct = YES;
        } else if([action isEqualToString:@"closebeak"]) {
            [self closeBeak];
            correct = YES;
        } else if([action isEqualToString:@"shake"]) {
            [self shake];
            correct = YES;
        } else if([action isEqualToString:@"eyes"]) {
            [self eyes];
            correct = YES;
        } else if([action isEqualToString:@"victory"]) {
            [self victory];
            correct = YES;
        } else if([action isEqualToString:@"match"]) {
            [self match];
            correct = YES;
        } else if([action isEqualToString:@"wrong"]) {
            [self wrong];
            correct = YES;
        }
        
        //if(correct) return NO;
        
    }
    
    /*
    if ( [[request URL] scheme] == @"callback:" ) {
        // Do something interesting...
        return YES;
    }
    */
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self logThis:@"webViewDidStartLoad"];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self logThis:@"webViewDidFinishLoad"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self logThis:[NSString stringWithFormat:@"didFailLoadWithError: %@", [error description]]];
    
}

- (IBAction) refreshPage:(id)sender {
    [self refreshURL];
}

- (IBAction) memoryGame:(id)sender {
    gameURL = @"http://ec2-23-20-52-60.compute-1.amazonaws.com/test.html";
    [self logThis:@"mem game"];
    [self refreshURL];
}

- (IBAction) mathGame:(id)sender {
    gameURL = @"http://eduboticsapp.appspot.com";
    [self logThis:@"math game"];
    [self refreshURL];
}

- (void) refreshURL {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:gameURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    [webView loadRequest:request];
    
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:gameURL]]];

    
}

#pragma RoboBrrd

- (IBAction) test1:(id)sender {
    [self logThis:@"test1"];
    [self sendAction:0 command:0];
}

- (IBAction) test2:(id)sender {
    [self logThis:@"test2"];
    [self sendAction:1 command:0];
}

- (void) leftWing {
    [self logThis:@"leftWing"];
    [self sendAction:0 command:0];
}

- (void) rightWing {
    [self logThis:@"rightWing"];
    [self sendAction:1 command:0];
}

- (void) openBeak {
    [self logThis:@"openBeak"];
    [self sendAction:2 command:0];
}

- (void) closeBeak {
    [self logThis:@"closeBeak"];
    [self sendAction:3 command:0];
}

- (void) shake {
    [self logThis:@"shake"];
    [self sendAction:4 command:0];
}

- (void) eyes {
    [self logThis:@"eyes"];
    [self sendAction:5 command:0];
}

- (void) victory {
    [self logThis:@"victory"];
    [self sendAction:6 command:0];
}

- (void) match {
    [self logThis:@"match"];
    [self sendAction:7 command:0];
}

- (void) wrong {
    [self logThis:@"wrong"];
    [self sendAction:8 command:0];
}

#pragma Logger

- (void) logThis:(NSString *)s {
        
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm-ss-SSS"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];

    NSString *logText = [NSString stringWithFormat:@"%@ : %@\n", dateString, s];
    
    [logView insertText:logText];
    // todo; make this to delete lines after a large amount to prevent lag
}

@end
