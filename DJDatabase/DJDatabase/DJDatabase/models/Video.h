//
//  Video.h
//  DJDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Video : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * url;

@end
