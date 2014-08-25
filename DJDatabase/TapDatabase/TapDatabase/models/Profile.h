//
//  Profile.h
//  TapDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tap, Event, Venue, Video;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * handle;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) Tap *tap;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) NSManagedObject *image;
@property (nonatomic, retain) Venue *venue;
@property (nonatomic, retain) Video *video;

@end
