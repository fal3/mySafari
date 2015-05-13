//
//  ViewController.m
//  Safari
//
//  Created by alex fallah on 5/13/15.
//  Copyright (c) 2015 alex fallah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityInwdicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestWithText:@"http://www.afallah.com"];
    self.webView.delegate = self;
}

#pragma mark - UIWebViewDelegate Methods
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = true;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alertView = [[UIAlertView alloc]init];
    alertView.title = @"Failed to load webpage";
    alertView.message = @"Try a different url";
    [alertView addButtonWithTitle:@"Dismiss"];
    [alertView addButtonWithTitle:@"Reload"];
    alertView.delegate = self;
    //for the alertview this view controller will have the delgate for the instance of self
    [alertView show];
    self.activityIndicator.hidden = true;
}

#pragma mark - UITextFieldDelegate Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self loadRequestWithText:textField.text];
    return YES;

}

#pragma mark - UIAlertViewDelegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self loadRequestWithText:@"http://www.afallah.com"];
    }
}

-(void)loadRequestWithText:(NSString *)text
{
    NSURL *url = [NSURL URLWithString:text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: request];
}



@end
