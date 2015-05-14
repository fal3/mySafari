//
//  ViewController.m
//  Safari
//
//  Created by alex fallah on 5/13/15.
//  Copyright (c) 2015 alex fallah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;



@property NSString *beforeURL;
@property NSString *currentURL;



@property CGFloat previousOffset;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestWithText:@"http://www.afallah.com"];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;

}

#pragma mark - UIWebViewDelegate Methods
-(void)webViewDidStartLoad:(UIWebView *)webView
{

    [self.activityIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

//    self.webView.scrollView.delegate = self;
//    self.textField.text =self.webView.request.URL.absoluteString;
//    self.textField.placeholder = self.webView.request.URL.absoluteString;


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

    [self scrollViewDidScroll:self.webView.scrollView];

//    self.textField.text = webView.request.URL.absoluteString;
//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];



//    if (self.scrollView.sc == true) {
//        self.textField.hidden = false;
//
//    }

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
    //    [textField resignFirstResponder];
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
//    self.currentURL = text;
//    self.textField.text = self.currentURL;
    [self.webView loadRequest: request];
}




- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self.webView goBack];
//    self.textField.text =self.webView.request.URL.absoluteString;
//
//    NSLog(self.textField.text);


    //[self loadRequestWithText:self.currentURL];
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
//    self.textField.text =self.webView.request.URL.absoluteString;
//
//    NSLog(self.textField.text);
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
//    self.webView.pageCount
}
- (IBAction)plusButton:(UIButton *)sender {
    UIAlertView *plusView = [[UIAlertView alloc]init];
    plusView.title = @"Coming Soon!";
    [plusView addButtonWithTitle:@"Dismiss"];
    plusView.delegate = self;
    [plusView show];
    self.activityIndicator.hidden = true;

}





#pragma mark - UIScrollview methods

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (self.webView.scrollView.contentOffset.y > self.webView.scrollView.contentOffset.y)
//
//    else if (self.lastContentOffset < scrollView.contentOffset.x)
//        scrollDirection = ScrollDirectionLeft;
//
//    self.lastContentOffset = scrollView.contentOffset.x;
//
//    // do whatever you need to with scrollDirection here.
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    ScrollDirection scrollDirection;
//    if (self.webView.scrollView.contentOffset > self.webView.scrollView.contentOffset.y)
//        scrollDirection = ScrollDirectionRight;
//    else if (self.lastContentOffset < scrollView.contentOffset.x)
//        scrollDirection = ScrollDirectionLeft;
//
//    self.lastContentOffset = scrollView.contentOffset.x;
//
//    // do whatever you need to with scrollDirection here.
//}
//
//typedef enum ScrollDirection {
//    ScrollDirectionNone,
//    ScrollDirectionRight,
//    ScrollDirectionLeft,
//    ScrollDirectionUp,
//    ScrollDirectionDown,
//    ScrollDirectionCrazy,
//} ScrollDirection;}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    self.textField.hidden = false;
}






@end
