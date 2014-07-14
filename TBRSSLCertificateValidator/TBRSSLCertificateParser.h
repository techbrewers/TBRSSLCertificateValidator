//
//  TBRSSLCertificateParser.h
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBRSSLCertificateParser : NSObject

/**
 *  Method for returning SHA1 finger from certificate
 *
 *  @param certificateData A DER representation of a certificate given a certificate object.
 *
 *  @return SHA1 fingerprint string
 */
+ (NSString *)SHA1FingerPrintFromCertificateData:(NSData *)certificateData;

/**
 *  Method for returning MD5 finger from certificate
 *
 *  @param certificateData A DER representation of a certificate given a certificate object.
 *
 *  @return MD5 fingerprint string
 */
+ (NSString *)MD5FingerPrintFromCertificateData:(NSData *)certificateData;

@end
