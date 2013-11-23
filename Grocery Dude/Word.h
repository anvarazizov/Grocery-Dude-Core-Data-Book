//
//  Word.h
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-23.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * ukr;
@property (nonatomic, retain) NSString * uzb;

@end
