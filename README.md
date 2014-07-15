TBRSSLCertificateValidator
==========================

Objective C classes used to validate SSL certificates using sha1 and md5 fingerprints


Supported OS & SDK Versions
-----------------------------

* Earliest supported deployment target - iOS 5.0

Installation
-------------

* Add the classes inside TBRSSLCertificateValidator folder to your project
	*	TBRSSLCertificateValidator
	*	TBRSSLCertificateModel
	*	TBRSSLCertificateParser


Example
-----------------------
```objc
static NSString *const kTestURL = @"https://github.com/";
static NSString *const kGithubRootMD5Fingerprint = @"D4 74 DE 57 5C 39 B2 D3 9C 85 83 C5 C0 65 49 8A";
static NSString *const kGithubRootSHA1Fingerprint = @"5F B7 EE 06 33 E2 59 DB AD 0C 4C 9A E6 D3 8F 1A 61 C7 DC 25";

TBRSSLCertificateModel *remoteSSLCertificateModel = [[TBRSSLCertificateModel alloc] initWithMD5Fingerprint:kGithubRootMD5Fingerprint
                                                                                           SHA1Fingerprint:kGithubRootSHA1Fingerprint];

NSArray *arrayOfValidCeritifcates = @[remoteSSLCertificateModel];

// Create a property for a TBRSSLCertificateValidator instance
self.SSLCertitificateValidator =  [[TBRSSLCertificateValidator alloc] initWithArrayOfValidCertificates:arrayOfValidCertificates];
```

In NSURLSessionDelegate:
```objc
- (void) URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *credential))completionHandler
{
    [self.SSLCertitificateValidator validateChallenge:challenge
                                    completionHandler:completionHandler];
}
```

In NSURLConnectionDelegate:
```objc
- (void)connection:(NSURLConnection *)connection
willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [self.SSLCertitificateValidator validateChallenge:challenge];
}
```


License
==================

The MIT License (MIT)

Copyright (c) 2014 TechBrewers LTD.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.