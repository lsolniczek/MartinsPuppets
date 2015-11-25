//
//  Character.h
//  GOTArticles
//
//  Created by Lukasz on 21/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Character : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnailPath;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, assign) BOOL ready;
@property (nonatomic, assign) BOOL favorite;
@property (nonatomic, strong) NSString *wikiArticelPath;

-(id)initWithJSON:(NSDictionary*)json;
-(void)updateWithThumbnail:(UIImage *)newThumbnail;

@end
