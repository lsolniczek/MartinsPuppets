//
//  MainTableViewCell.m
//  GOTArticles
//
//  Created by Lukasz on 19/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    [self addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    self.favoriteImage.userInteractionEnabled = YES;
    [self.favoriteImage addGestureRecognizer:tap];
}

-(void)longPressHandler:(UILongPressGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.delegate) {
            [self.delegate tableViewCell:self didLongPressed:sender];
        }
    }
}

-(void)tapHandler:(UITapGestureRecognizer*)sender {
    if (self.delegate) {
        self.character.favorite = !self.character.favorite;
        [self.delegate tableViewCell:self didChooseFavoriteCharacter:self.character];
    }
}

@end
