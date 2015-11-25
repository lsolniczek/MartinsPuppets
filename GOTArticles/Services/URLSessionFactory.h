//
//  URLSessionFactory.h
//  GOTArticles
//
//  Created by Lukasz on 25/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ DataResponseBlock)(NSData *data, NSURLResponse *response, NSError *error);
typedef void (^ DownloadResponseBlock)(NSURL *location, NSURLResponse *response, NSError *error);

@interface URLSessionFactory : NSObject

-(void)resumeDataTaskWithPath:(NSString *)path responseHandler:(DataResponseBlock)handler;
-(void)resumeDownloadTaskWithPath:(NSString *)path responseHandler:(DownloadResponseBlock)handler;

@end
