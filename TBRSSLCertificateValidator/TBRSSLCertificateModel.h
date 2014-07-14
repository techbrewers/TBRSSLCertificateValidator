//
//  TBRSSLCertificateModel.h
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBRSSLCertificateModel : NSObject

@property (nonatomic, copy, readonly) NSString *MD5Fingerprint;
@property (nonatomic, copy, readonly) NSString *SHA1Fingerprint;

/**
 *  Designated initializer for creating TBRSSLCertificateModel object
 *
 *  @param MD5Fingerprint  MD5 fingerprint string
 *  @param SHA1Fingerprint SHA1 fingerprint string
 *
 *  @return The initialized object
 */
- (instancetype)initWithMD5Fingerprint:(NSString *)MD5Fingerprint
                       SHA1Fingerprint:(NSString *)SHA1Fingerprint __attribute__((objc_designated_initializer));

/**
 *  Initializer for creating TBRSSLCertificateModel object with certificate data from connection delegate
 *
 *  @param certificateData The DER representation of the certificate
 *
 *  @return The initialized object
 */
- (instancetype)initWithCertificateData:(NSData *)certificateData;



- (BOOL)isEqualToSSLCertificateModel:(TBRSSLCertificateModel *)SSLCertificateModel;

@end
