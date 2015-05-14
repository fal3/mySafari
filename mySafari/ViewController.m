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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;





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

    if (self.webView.canGoBack) {
        self.backButton.enabled = true;
    }
    else{
        self.backButton.enabled = false;
    }
    if (self.webView.canGoForward)
    {
        self.forwardButton.enabled = true;
    }
    else
    {
        self.forwardButton.enabled = false;
    }
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = true;


//        // Only report feedback for the main frame.
//    if (frame == [sender mainFrame]){
//        [backButton setEnabled:[sender canGoBack]];
//        [forwardButton setEnabled:[sender canGoForward]];
//        }



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
    if ([textField.text containsString:@"http://"]) {
        [textField resignFirstResponder];
    }
    else{
        textField.text = [NSString stringWithFormat:@"https://%@",textField.text];

    }
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



- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
//    self.webView.pageCount
}











@end
