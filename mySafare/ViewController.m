//
//  ViewController.m
//  mySafare
//
//  Created by Alex Santorineos on 5/13/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleURL;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@property NSURL *url1;

@end

@implementation ViewController

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];

}

- (IBAction)onAddButtonTapped:(id)sender {

    UIAlertView *alert = [UIAlertView new];
    alert.title = @"Coming Soon";
    [alert addButtonWithTitle:@"Dismiss"];
    alert.delegate = self;
    [alert show];


}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    [alertView dismissWithClickedButtonIndex:0 animated:TRUE];
}



- (IBAction)onBackButtonPressed:(id)sender {

    [self.webView goBack];

}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {

    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {

    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate = self;
    self.urlTextField.delegate = self;

    [self.backButton setEnabled:YES];
    [self.backButton setEnabled:NO];

    [self.forwardButton setEnabled:YES];
    [self.forwardButton setEnabled:NO];


}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

            [self.spinner stopAnimating];


    //button is enabled only if you can go forward [or] backward
    [self.backButton setEnabled:[webView canGoBack]];

    [self.forwardButton setEnabled:[webView canGoForward]];
 self.titleURL.text =[webView stringByEvaluatingJavaScriptFromString:@"document.title"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if ([textField.text containsString:@"http://"]||[textField.text containsString:@"https://"]) {

        NSString *urlString = textField.text;

        self.url1= [NSURL URLWithString:urlString];

        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url1];

        [self.webView loadRequest:urlRequest];



    }
    else{

        NSString *urlString = [NSString stringWithFormat:@"http://%@",textField.text];


       self.url1 = [NSURL URLWithString:urlString];

        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url1];

        [self.webView loadRequest:urlRequest];

    }




    return YES;
//
//
//    NSString *stringUrl = textField.text;
//    NSURL *url = [NSURL URLWithString:stringUrl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
//
//    return YES;


}


@end
