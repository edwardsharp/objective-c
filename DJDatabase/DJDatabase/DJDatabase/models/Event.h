//
//  Event.h
//  DJDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * cost;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) Image *image;

@end
