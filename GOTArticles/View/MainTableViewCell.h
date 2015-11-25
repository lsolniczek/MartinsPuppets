//
//  MainTableViewCell.h
//  GOTArticles
//
//  Created by Lukasz on 19/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewCellDelegate.h"
#import "Character.h"

@interface MainTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *abstract;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;

@property (nonatomic, strong) Character *character;
@property (nonatomic, weak) id<MainTableViewCellDelegate> delegate;

@end
