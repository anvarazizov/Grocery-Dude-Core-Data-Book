//
//  Item.h
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-23.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Unit;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber *collected;
@property (nonatomic, retain) NSNumber *listed;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSData *photoData;
@property (nonatomic, retain) NSNumber *quantity;
@property (nonatomic, retain) Unit *unit;

@end
