//
//  TBRSSLCertificateValidator.m
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import "TBRSSLCertificateValidator.h"
#import "TBRSSLCertificateModel.h"

@interface TBRSSLCertificateValidator ()

@property (nonatomic, strong) NSArray *validCertificatesArray;

@end

@implementation TBRSSLCertificateValidator

#pragma mark - Object lifecycled

- (instancetype)initWithArrayOfValidCertificates:(NSArray *)validCertificatesArray
{
    NSParameterAssert(validCertificatesArray);
    self = [super init];
    if (self) {
        _validCertificatesArray = validCertificatesArray;
    }
    return self;
}

- (instancetype)init
{
    // Prevents use of init method as this will cause an assertion
    return [self initWithArrayOfValidCertificates:nil];
}

#pragma mark - Public methods

- (BOOL)isAtLeastOneValidCertiticateForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    SecTrustRef remoteSSLTransactionState = [[challenge protectionSpace] serverTrust];
    
    CFIndex numberOfCertificates = SecTrustGetCertificateCount(remoteSSLTransactionState);
    
    for (CFIndex i = 0; i <numberOfCertificates; i++) {
        SecCertificateRef remoteCertificate = SecTrustGetCertificateAtIndex(remoteSSLTransactionState, i);
        NSData *certificateData = (__bridge NSData *) SecCertificateCopyData(remoteCertificate);
        TBRSSLCertificateModel *remoteSSLCertificateModel = [[TBRSSLCertificateModel alloc] initWithCertificateData:certificateData];
        
        if ([self isValidCertificate:remoteSSLCertificateModel]) {
            return YES;
        }
        
    }
    return NO;
}

#pragma mark - Private methods

- (BOOL)isValidCertificate:(TBRSSLCertificateModel *)SSLCertificateModel
{
    for (TBRSSLCertificateModel *validCertificates in self.validCertificatesArray) {
        if ([validCertificates isEqualToSSLCertificateModel:SSLCertificateModel]) {
            return YES;
        }
    }
    
    return NO;
}

@end
