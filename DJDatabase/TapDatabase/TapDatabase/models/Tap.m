//
//  Tap.m
//  TapDatabase
//
//  Created by edward on 4/23/13.
//  Copyright (c) 2013 singlemind. All rights reserved.
//

#import "Tap.h"
#import "Profile.h"
#import "Image.h"


@implementation Tap

@dynamic bio;
@dynamic id;
@dynamic name;
@dynamic thumbnailImage;
@dynamic twitter;
@dynamic image;
@dynamic profile;

@end


@implementation ImageToDataTransformer


+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value {
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
	return uiImage;
}

@end