//
//  MainTableViewController.m
//  GOTArticles
//
//  Created by Lukasz on 19/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "Character.h"
#import "CharacterDetailsViewController.h"
#import "UIImage+Favorite.h"
#import "URLSessionFactory.h"

@interface MainTableViewController ()

@property (nonatomic, strong) NSMutableArray *serializedCharacters;
@property (nonatomic, strong) NSMutableArray *favoriteCharacters;
@property (nonatomic, strong) NSArray *vcDataSource;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) URLSessionFactory *urlSessionFactory;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Game of Throne Characters"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage favoriteOnImage] style:UIBarButtonItemStylePlain target:self action:@selector(filterFavorite:)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"CharacterCell"];
    
    _serializedCharacters = [[NSMutableArray alloc] init];
    _favoriteCharacters = [[NSMutableArray alloc] init];
    _vcDataSource = [[NSArray alloc] init];
    _urlSessionFactory = [[URLSessionFactory alloc] init];
    [self fetchCharacters];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_vcDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = (MainTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"CharacterCell"];
    Character *character = _vcDataSource[indexPath.row];
    cell.character = character;
    cell.title.text = character.title;
    cell.abstract.text = character.abstract;
    cell.thumbnail.image = character.thumbnail;
    cell.favoriteImage.image = character.favorite ? [UIImage favoriteOnImage] : [UIImage favoriteOffImage];
    cell.delegate = self;
    [self updateCharacterCellWithIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == _selectedIndexPath) {
        return 130.0;
    }
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CharacterDetailsViewController *vc = [[CharacterDetailsViewController alloc] initWithNibName:@"CharacterDetailsViewController" bundle:nil];
    vc.character = _vcDataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - TableViewCell GestureRecognizer Delegate Methods

-(void)tableViewCell:(UITableViewCell *)cell didLongPressed:(UILongPressGestureRecognizer *)longPress {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ((_selectedIndexPath != nil) && (_selectedIndexPath == indexPath)) {
        _selectedIndexPath = nil;
    } else {
        _selectedIndexPath = indexPath;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)tableViewCell:(UITableViewCell *)cell didChooseFavoriteCharacter:(Character *)character {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([_favoriteCharacters containsObject:character]) {
        [_favoriteCharacters removeObject:character];
    } else {
        [_favoriteCharacters addObject:character];
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)filterFavorite:(UIBarButtonItem *)sender {
    if (_vcDataSource == _serializedCharacters) {
        _vcDataSource = _favoriteCharacters;
    } else {
        _vcDataSource = _serializedCharacters;
    }
    [self.tableView reloadData];
}

#pragma mark - URLSessionHelperMethods

-(void)fetchCharacters {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_urlSessionFactory resumeDataTaskWithPath:@"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75" responseHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSError *jsonError;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            NSArray *characters = jsonDic[@"items"];
            [userDefaults setObject:jsonDic[@"basepath"] forKey:@"wikiBasePath"];
            [userDefaults synchronize];
            
            for (int i = 0; i < [characters count]; i++) {
                Character *character = [[Character alloc] initWithJSON:characters[i]];
                [_serializedCharacters addObject:character];
            }
            _vcDataSource = _serializedCharacters;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)updateCharacterCellWithIndexPath:(NSIndexPath *)indexPath {
    Character *character = (Character *)_vcDataSource[indexPath.row];
    if (!character.ready && character.thumbnailPath != (id)[NSNull null]) {
        [_urlSessionFactory resumeDownloadTaskWithPath:character.thumbnailPath responseHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            UIImage *thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [character updateWithThumbnail:thumbnail];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
        }];
    }
}
@end
