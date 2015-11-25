//
//  MainTableViewController.h
//  GOTArticles
//
//  Created by Lukasz on 19/11/15.
//  Copyright © 2015 Lukasz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewCellDelegate.h"

@interface MainTableViewController : UITableViewController<MainTableViewCellDelegate, NSURLSessionTaskDelegate>

@end
