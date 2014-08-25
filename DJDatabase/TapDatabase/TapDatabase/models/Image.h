//
//  Image.h
//  TapDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tap, Event, Profile, Venue;

@interface Image : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) Tap *tap;
@property (nonatomic, retain) Event *event;
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) Venue *venue;

@end
