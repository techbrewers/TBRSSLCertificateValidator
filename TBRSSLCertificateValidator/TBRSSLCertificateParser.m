//
//  TBRSSLCertificateParser.m
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import "TBRSSLCertificateParser.h"
#import <CommonCrypto/CommonCrypto.h>

typedef NS_ENUM(NSInteger, TBRSSLCertificateParserHashFunction) {
    TBRSSLCertificateParserHashFunctionSHA1,
    TBRSSLCertificateParserHashFunctionMD5
};

@implementation TBRSSLCertificateParser

#pragma mark - Public methods

+ (NSString *)SHA1FingerPrintFromCertificateData:(NSData *)certificateData{
    
    return [self fingerPrintFromCertificateData:certificateData
                                forHashFunction:TBRSSLCertificateParserHashFunctionSHA1];
}

+ (NSString *)MD5FingerPrintFromCertificateData:(NSData *)certificateData
{
    return [self fingerPrintFromCertificateData:certificateData
                                forHashFunction:TBRSSLCertificateParserHashFunctionMD5];
}

#pragma mark - Private methods

+ (NSString *)fingerPrintFromCertificateData:(NSData *)certificateData
                             forHashFunction:(TBRSSLCertificateParserHashFunction)hashFunction
{
 
    const NSUInteger hashFunctionDigestLength = [self digestLengthForHashFunction:hashFunction];
    unsigned char hashFunctionBuffer[hashFunctionDigestLength];
    switch (hashFunction) {
        case TBRSSLCertificateParserHashFunctionSHA1: {
            CC_SHA1(certificateData.bytes, (CC_LONG)certificateData.length, hashFunctionBuffer);
            break;
            
        }
            
        case TBRSSLCertificateParserHashFunctionMD5: {
            CC_MD5(certificateData.bytes, (CC_LONG)certificateData.length, hashFunctionBuffer);
            break;
        }
    }
    
    NSMutableString *fingerprint = [NSMutableString stringWithCapacity:hashFunctionDigestLength * 3];
    
    for (int i = 0; i < hashFunctionDigestLength; ++i) {
        [fingerprint appendFormat:@"%02x ",hashFunctionBuffer[i]];
    }
    return [fingerprint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSUInteger)digestLengthForHashFunction:(TBRSSLCertificateParserHashFunction)hashFunction
{
    switch (hashFunction) {
        case TBRSSLCertificateParserHashFunctionSHA1: {
            return CC_SHA1_DIGEST_LENGTH;
        }
            
        case TBRSSLCertificateParserHashFunctionMD5: {
            return CC_MD5_DIGEST_LENGTH;
        }
    }
}


@end
