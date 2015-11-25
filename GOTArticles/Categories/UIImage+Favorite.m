//
//  ViewController.m
//  GOTArticles
//
//  Created by Lukasz on 24/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import "UIImage+Favorite.h"

@implementation UIImage (Favorite)

+(UIImage *)favoriteOnImage {
    return [UIImage imageNamed:@"favorite-on"];
}

+(UIImage *)favoriteOffImage {
    return [UIImage imageNamed:@"favorite-off"];
}

@end
