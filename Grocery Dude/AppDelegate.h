//
//  AppDelegate.h
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-17.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) CoreDataHelper *coreDataHelper;

-(CoreDataHelper *)cdh;

@end
