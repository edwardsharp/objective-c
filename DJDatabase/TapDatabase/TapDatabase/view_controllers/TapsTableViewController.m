//
//  TapsTableViewController.m
//  TapDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import "TapsTableViewController.h"
#import "TapsTableViewCell.h"
#import "Tap.h"
#import "Image.h"

@interface TapsTableViewController ()

@end

@implementation TapsTableViewController

@synthesize managedObjectContext;

//example stubs.
@synthesize tapImages; //= _tapImages;
@synthesize tapNames; //= _tapNames;
@synthesize tapNamesSearchResults; //= _tapNamesSearchResults;
@synthesize tapSearchBar;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableBg2.png"]];

    
    UIImage *background = [UIImage imageNamed:@"TableBg2.png"];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:background];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    tapSearchBar.delegate = (id)self;
    
    self.tapNames = [[NSArray alloc]
                    initWithObjects: @"Tap Foobar",
                    @"Tap F00B@Z",
                    @"Tap BARBAZ",
                    @"Tap Whatever",
                    @"Tap Tap",
                    @"Tap BAZBAZ",
                    @"Tap Foobar",
                    @"Tap F00B@Z",
                    @"Tap BARBAZ",
                    @"Tap Whatever",
                    @"Tap Tap",
                    @"Tap BAZBAZ",
                    @"Tap Foobar",
                    @"Tap F00B@Z",
                    @"Tap BARBAZ",
                    @"Tap Whatever",
                    @"Tap Tap",
                    @"Tap BAZBAZ",
                    @"Tap Foobar",
                    @"Tap F00B@Z",
                    @"Tap BARBAZ",
                    @"Tap Whatever",
                    @"Tap Tap",
                    @"Tap BAZBAZ",
                    nil ];
    self.tapImages = [[NSArray alloc]
                     initWithObjects:@"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     @"first.png",
                     @"second.png",
                     nil];
    
     //[self.tableView reloadData];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section or in the search results
    
    NSInteger rows = 0;
    
    if ([tableView
         isEqual:self.searchDisplayController.searchResultsTableView]){
        rows = [self.tapNamesSearchResults count];
    }
    else{
        rows = [self.tapNames count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tapTableCell";
    
    //zomg! http://stackoverflow.com/questions/12737860/assertion-failure-in-dequeuereusablecellwithidentifierforindexpath
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    // Configure the cell...
    if (cell == nil) {
        cell = [[TapsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
       
    }
    //Tap* tap;
    //Image* tapImage;
     if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        cell.textLabel.text = [self.tapNamesSearchResults objectAtIndex: [indexPath row]];
      //  tapImage = [self.tapImages objectAtIndex: [indexPath row]];
    } else {
        cell.textLabel.text = [self.tapNames objectAtIndex: [indexPath row]];
        //tapImage = [self.tapNames objectAtIndex: [indexPath row]];
    }

    
    UIImage *tapPhoto = [UIImage imageNamed: [self.tapImages objectAtIndex: [indexPath row]]];
    cell.imageView.image = tapPhoto;
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - search results callback..

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    self.tapNamesSearchResults = [self.tapNames filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    
    return YES;
}

@end
