//
//  Profile.h
//  DJDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DJ, Event, Image, Venue, Video;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * handle;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Image *image;
@property (nonatomic, retain) Venue *venue;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) DJ *dj;
@property (nonatomic, retain) Video *video;

@end
