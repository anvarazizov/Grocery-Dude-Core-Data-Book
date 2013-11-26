//
//  PrepareTVC.h
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-26.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTVC.h"

@interface PrepareTVC : CoreDataTVC <UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *clearConfirmActionSheet;

@end
