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
 *  Method for checking that at least one of the authentication challenge certificates match the
 *  valid ones provided
 *
 *  @param challenge The Authentication challenge from the connection delegate
 *
 *  @return YES if at least one of the challenge certificates matches the valid ones, NO if none match
 */
- (BOOL)isAtLeastOneValidCertiticateForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;

@end
