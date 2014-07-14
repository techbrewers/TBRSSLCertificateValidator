//
//  TBRSSLCertificateModel.m
//
//  Created by Luciano Marisi on 14/07/2014.
//  Copyright (c) 2014 TechBrewers LTD. All rights reserved.
//

#import "TBRSSLCertificateModel.h"
#import "TBRSSLCertificateParser.h"


@interface TBRSSLCertificateModel ()

@property (nonatomic, copy, readwrite) NSString *MD5Fingerprint;
@property (nonatomic, copy, readwrite) NSString *SHA1Fingerprint;

@end

@implementation TBRSSLCertificateModel


- (instancetype)initWithCertificateData:(NSData *)certificateData
{
    NSString *remoteSHA1FingerPrint = [TBRSSLCertificateParser SHA1FingerPrintFromCertificateData:certificateData];
    NSString *remoteMD5FingerPrint = [TBRSSLCertificateParser MD5FingerPrintFromCertificateData:certificateData];
    return [self initWithMD5Fingerprint:remoteMD5FingerPrint
                        SHA1Fingerprint:remoteSHA1FingerPrint];
}

- (instancetype)initWithMD5Fingerprint:(NSString *)MD5Fingerprint
                       SHA1Fingerprint:(NSString *)SHA1Fingerprint
{
    self = [super init];
    if (self) {
        _MD5Fingerprint = [MD5Fingerprint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _SHA1Fingerprint = [SHA1Fingerprint stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    return self;
}


- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[TBRSSLCertificateModel class]]) {
        return NO;
    }
    
    return [self isEqualToSSLCertificateModel:(TBRSSLCertificateModel *)object];
}

- (BOOL)isEqualToSSLCertificateModel:(TBRSSLCertificateModel *)SSLCertificateModel
{
    if (!SSLCertificateModel) {
        return NO;
    }
    
    BOOL haveEqualMD5Fingerprints = ([self.MD5Fingerprint caseInsensitiveCompare:SSLCertificateModel.MD5Fingerprint] == NSOrderedSame);
    BOOL haveEqualSHA1Fingerprints = ([self.SHA1Fingerprint caseInsensitiveCompare:SSLCertificateModel.SHA1Fingerprint] == NSOrderedSame);
    
    return haveEqualMD5Fingerprints && haveEqualSHA1Fingerprints;
}

- (NSUInteger)hash
{
    return [self.MD5Fingerprint hash] ^ [self.SHA1Fingerprint hash];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"MD5Fingerprint: %@ \n SHA1Fingerprint:%@", self.MD5Fingerprint,self.SHA1Fingerprint];
}
@end
