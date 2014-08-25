//
//  DetailViewController.h
//  PiVideoControl
//
//  Created by edward on 1/19/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
