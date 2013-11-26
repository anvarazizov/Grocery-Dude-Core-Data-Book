//
//  CoreDataTVC.h
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-24.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@interface CoreDataTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *frc;

-(void)performFetch;

@end
