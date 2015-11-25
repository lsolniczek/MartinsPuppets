//
//  URLSessionFactory.m
//  GOTArticles
//
//  Created by Lukasz on 25/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import "URLSessionFactory.h"

@interface URLSessionFactory()
@property (nonatomic, strong) NSURLSessionConfiguration *defaultConfig;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation URLSessionFactory

-(instancetype)init {
    self = [super init];
    if (self) {
        self.defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:self.defaultConfig];
    }
    return self;
}

-(void)resumeDataTaskWithPath:(NSString *)path responseHandler:(DataResponseBlock)handler {
    NSURL *url = [[NSURL alloc] initWithString:path];
    NSURLSessionTask *task = [self.session dataTaskWithURL:url completionHandler:handler];
    [task resume];
}

-(void)resumeDownloadTaskWithPath:(NSString *)path responseHandler:(DownloadResponseBlock)handler {
    NSURL *url = [[NSURL alloc] initWithString:path];
    NSURLSessionTask *task = [self.session downloadTaskWithURL:url completionHandler:handler];
    [task resume];
}


@end
