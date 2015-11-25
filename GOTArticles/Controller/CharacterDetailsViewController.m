//
//  CharacterDetailsViewController.m
//  GOTArticles
//
//  Created by Lukasz on 23/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import "CharacterDetailsViewController.h"
#import "UIImage+Favorite.h"

@interface CharacterDetailsViewController ()

@property (nonatomic, weak) IBOutlet UITextView *abstract;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;
@property (nonatomic, weak) IBOutlet UIImageView *favoriteImage;

@end

@implementation CharacterDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:self.character.title];
    _abstract.text = self.character.abstract;
    _thumbnail.image = self.character.thumbnail;
    _favoriteImage.image = self.character.favorite ? [UIImage favoriteOnImage] : [UIImage favoriteOffImage];
}

- (IBAction)showInSafari:(UIButton *)sender {
    UIApplication *app = [UIApplication sharedApplication];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSURL *baseURL = [[NSURL alloc] initWithString:[userDefaults objectForKey:@"wikiBasePath"]];
    NSURL *wikiURL = [[NSURL alloc] initWithString:self.character.wikiArticelPath relativeToURL:baseURL];
    if ([app canOpenURL:wikiURL]) {
        [app openURL:wikiURL];
    }
}


@end
