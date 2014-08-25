//
//  Tap.h
//  TapDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile;

@interface ImageToDataTransformer : NSValueTransformer {
}
@end

@interface Tap : NSManagedObject

@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
//@property (nonatomic, retain) id thumbnailImage;
@property (nonatomic, retain) NSString * twitter;
//@property (nonatomic, retain) Image *image;
@property (nonatomic, retain) Profile *profile;


@property (nonatomic, retain) UIImage *thumbnailImage;
@property (nonatomic, retain) NSManagedObject *image;

@end
