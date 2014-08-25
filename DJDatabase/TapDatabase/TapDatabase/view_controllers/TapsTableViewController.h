//
//  TapsTableViewController.h
//  TapDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapsTableViewController : UITableViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property (weak, nonatomic) IBOutlet UISearchBar *tapSearchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *tapSearchController;


//#TODO: use managed obj ctx...
//tapTableCell
@property (nonatomic, strong) NSArray *tapImages;
@property (nonatomic, strong) NSArray *tapNames;
@property (nonatomic, strong) NSArray *tapNamesSearchResults;

@end
