//
//  TBRSSLCertificateValidator.h
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBRSSLCertificateValidator : NSObject

/**
 *  Designated initializer
 *
 *  @param validCertificatesArray Array of TBRSSLCertificateModel instance for valid certificates
 *
 *  @return An instance of TBRSSLCertificateValidator
 */
- (instancetype)initWithArrayOfValidCertificates:(NSArray *)validCertificatesArray;

/**
 *  Validation method to be used with NSURLConnections
 *
 *  @param challenge The NSURLAuthenticationChallenge from the NSURLSessionDelegate callback
 */
- (void)validateChallenge:(NSURLAuthenticationChallenge *)challenge;

/**
 *  Validation method to be used with NSURLSession connections
 *
 *  @param challenge         The NSURLAuthenticationChallenge from the NSURLSessionDelegate callback
 *  @param completionHandler The completionHandler from the NSURLSessionDelegate callback
 */
- (void)validateChallenge:(NSURLAuthenticationChallenge *)challenge
        completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                                    NSURLCredential *credential))completionHandler;


@end