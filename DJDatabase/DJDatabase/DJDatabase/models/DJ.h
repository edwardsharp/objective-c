//
//  DJ.h
//  DJDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface DJ : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) Image *image;

@end
