//
//  MainTableViewCellDelegate.h
//  GOTArticles
//
//  Created by Lukasz on 21/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Character.h"

@protocol MainTableViewCellDelegate
- (void)tableViewCell:(UITableViewCell *)cell didLongPressed:(UILongPressGestureRecognizer *)longPress;
- (void)tableViewCell:(UITableViewCell *)cell didChooseFavoriteCharacter:(Character *)character;
@end
