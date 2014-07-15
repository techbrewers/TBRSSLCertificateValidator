//
//  ViewController.m
//  TBRSSLCertificateValidatorExample
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import "ViewController.h"
#import "TBRSSLCertificateValidator.h"
#import "TBRSSLCertificateModel.h"
#import "TBRSSLCertificateParser.h"


static NSString *const kTestURL = @"https://github.com/";
static NSString *const kGithubRootMD5Fingerprint = @"D4 74 DE 57 5C 39 B2 D3 9C 85 83 C5 C0 65 49 8A";
static NSString *const kGithubRootSHA1Fingerprint = @"5F B7 EE 06 33 E2 59 DB AD 0C 4C 9A E6 D3 8F 1A 61 C7 DC 25";

@interface ViewController ()  <NSURLSessionDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) TBRSSLCertificateValidator *SSLCertitificateValidator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.SSLCertitificateValidator = [[TBRSSLCertificateValidator alloc] initWithArrayOfValidCertificates:@[[self testRootCertificate]]];
}

#pragma mark - NSURLConnection



- (IBAction)connectUsingNSURLConnection:(UIButton *)sender
{
    (void)[[NSURLConnection alloc] initWithRequest:[self urlRequest]
                                          delegate:self
                                  startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection
willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    BOOL isAtLeastOneCertificateValid = [self.SSLCertitificateValidator isAtLeastOneValidCertiticateForAuthenticationChallenge:challenge];
    
    SecTrustRef remoteSSLTransactionState = [[challenge protectionSpace] serverTrust];
    
    
    if (isAtLeastOneCertificateValid) {
        SecTrustResultType trustEvaluateResult;
        OSStatus trustEvaluateOSStatus = SecTrustEvaluate(remoteSSLTransactionState, &trustEvaluateResult);
        
        BOOL trusted = (trustEvaluateOSStatus == noErr) &&
                        ((trustEvaluateResult == kSecTrustResultProceed) || (trustEvaluateResult == kSecTrustResultUnspecified));
        
        if(trusted) {
            [challenge.sender performDefaultHandlingForAuthenticationChallenge:challenge];
        } else {
            [challenge.sender cancelAuthenticationChallenge:challenge];
        }
        
    } else {
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"NSURLConnection httpResponse:%@",[httpResponse allHeaderFields]);
}

#pragma mark - NSURLSession

- (IBAction)connectUsingNSURLSession:(UIButton *)sender
{
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                             delegate:self
                                                        delegateQueue:nil];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:kTestURL]];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest
                                                   completionHandler:^(NSData *data,
                                                                       NSURLResponse *response,
                                                                       NSError *error) {
                                                       
                                                       NSLog(@"error:%@", error);
                                                       
                                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                       NSLog(@"httpResponse:%@",[httpResponse allHeaderFields]);
                                                   }];
    [dataTask resume];
}

- (void) URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *credential))completionHandler
{    
    BOOL isAtLeastOneCertificateValid = [self.SSLCertitificateValidator isAtLeastOneValidCertiticateForAuthenticationChallenge:challenge];
    
    if (isAtLeastOneCertificateValid) {
        
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
        
    } else {
        
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
   
    
}

#pragma mark - Helper methods

- (NSURLRequest *)urlRequest
{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:kTestURL]];
}

- (TBRSSLCertificateModel *)testRootCertificate
{
    return [[TBRSSLCertificateModel alloc] initWithMD5Fingerprint:kGithubRootMD5Fingerprint
                                                  SHA1Fingerprint:kGithubRootSHA1Fingerprint];
}

@end
