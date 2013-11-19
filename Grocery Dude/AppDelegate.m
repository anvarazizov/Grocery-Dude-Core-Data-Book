//
//  AppDelegate.m
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-17.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import "AppDelegate.h"
#import "Item.h"
#import "Amount.h"

@implementation AppDelegate

#define debug 1

- (CoreDataHelper *)cdh {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    if (!_coreDataHelper) {
        _coreDataHelper = [CoreDataHelper new];
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    [[self cdh] saveContext];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [[self cdh] saveContext];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    [self cdh];
    [self demoMeasurementInsert];
}

// метод для записування даних (об’єктів) в базу
- (void)insertDemo {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSArray *newItemNames = [NSArray arrayWithObjects:@"Apple", @"Coffee", @"Cheese", nil];
    
    for (NSString *newItemName in newItemNames) {
        Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:_coreDataHelper.context];
        newItem.name = newItemName;
        NSLog(@"Inserted New Managed Object: %@", newItem.name);
    }
}
/*
- (void)demo {
    
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    // як забирати дані з бази в циклі
    // створюємо екземпляр класу для витягнення даних з ім’ям Entity
    //NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Measurement"];
    
    
    // приклад фільтрування за допомогою створення шаблону NSFetchRequest
    // так можна робити чудові фільтри у мовних словниках
    NSFetchRequest *request = [[[_coreDataHelper model] fetchRequestTemplateForName:@"Test"] copy];
    [request setFetchLimit:50]; // лімітування виведення об’єктів. Добре поєднується з сортуванням
    
    
    // описуємо порядок сортування результат запиту
    //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    //[request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    // фільтруємо результат запиту за допомогою NSPredicate
    // NSPredicate *filter = [NSPredicate predicateWithFormat:@"name != %@", @"Apples"];
    // [request setPredicate:filter];
    
    // створюємо масив куди збираємо об’єкти з Entity
    NSError *error = nil;
    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
    
    if (error) {NSLog(@"%@", error);}
    else {
    
    // проходимося циклом по масиву і виводимо інформацію в лог
    for (Measurement *measurement in fetchedObjects) {
        NSLog(@"Fetched Object = %@", measurement.abc);
//        [_coreDataHelper.context deleteObject:item];
        }
    }
}
*/

-(void)demoMeasurementInsert {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Amount"];
    [request setFetchLimit:10];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    } else {
        for (Amount *amount in fetchedObjects) {
            NSLog(@"Fetched object = %@", amount.xyz);
        }
    }
    
    
    
//    for (int i = 1; i < 50000; i++) {
//        Measurement *newMeasurement = [NSEntityDescription insertNewObjectForEntityForName:@"Measurement" inManagedObjectContext:_coreDataHelper.context];
//        newMeasurement.abc = [NSString stringWithFormat:@"-->> LOTS OF TEST DATA: x%i", i];
//        NSLog(@"Inserted %@", newMeasurement.abc);
//    }
//    
//    [_coreDataHelper saveContext];
}

- (void)demoWithNumbers {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSLog(@"Integer 16 Range: %d to %d", INT16_MIN, INT16_MAX);
    NSLog(@"Integer 32 Range: %d to %d", INT32_MIN, INT32_MAX);
    NSLog(@"Integer 64 Range: %lld to %lld", INT64_MIN, INT64_MAX);
    NSLog(@"Float Range = %f to %f", -FLT_MAX, FLT_MAX);
    NSLog(@"Double Range = %f to %f", -DBL_MAX, DBL_MAX);
    NSLog(@"Decimal Range = %@ to %@", [NSDecimalNumber minimumDecimalNumber], [NSDecimalNumber maximumDecimalNumber]);
    
    NSLog(@"    Float 1/3 = %@", [NSNumber numberWithFloat:1.0f/3]);
    NSLog(@"    Double 1/3 = %@", [NSNumber numberWithDouble:1.0/3]);
    NSLog(@"    Decimal 1/3 = %@", [[NSDecimalNumber one] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"3"]]);
}

@end
