//
//  Character.m
//  GOTArticles
//
//  Created by Lukasz on 21/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import "Character.h"

@implementation Character

-(id)initWithJSON:(NSDictionary *)json {
    if ((self = [super init])) {
        self.title = json[@"title"];
        self.thumbnailPath = json[@"thumbnail"];
        self.thumbnail = [UIImage imageNamed:@"placeholder"];
        self.abstract = json[@"abstract"];
        self.favorite = NO;
        self.ready = NO;
        self.wikiArticelPath = json[@"url"];
    }
    return self;
}

-(void)updateWithThumbnail:(UIImage *)newThumbnail {
    self.ready = YES;
    self.thumbnail = newThumbnail;
}

@end
