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
#import "Unit.h"

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
    [self demo];
}

-(void)demo {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
   
    NSLog(@"Before deletion of the unit entity:");
    [self showUnitAndItemsCount];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name == %@", @"Kg"];
    [request setPredicate:filter];
    NSArray *kgUnit = [[[self cdh] context] executeFetchRequest:request error:nil];
    for (Unit *unit in kgUnit) {
        [_coreDataHelper.context deleteObject:unit];
        NSLog(@"A Kg unit object was deleted");
    }
    
    NSLog(@"After deletion of the unit entity:");
    [self showUnitAndItemsCount];
    
}

- (void)showUnitAndItemsCount {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSFetchRequest *items = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    
    NSError *itemsError = nil;
    NSArray *fetchedItems = [[[self cdh] context] executeFetchRequest:items error:&itemsError];
    
    if (!fetchedItems) {NSLog(@"%@", itemsError);}
    else {
            NSLog(@"Found %lu items(s) ", (unsigned long)[fetchedItems count]);
    }
    
    NSFetchRequest *units = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    
    NSError *unitsError = nil;
    NSArray *fetchedUnits = [[[self cdh] context] executeFetchRequest:units error:&unitsError];
    
    if (!fetchedUnits) {NSLog(@"%@", unitsError);}
    else {
        NSLog(@"Found %lu unit(s) ", (unsigned long)[fetchedUnits count]);
    }

    
    
}
// метод для записування даних (об’єктів) в базу
- (void)insertDemo {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSArray *newItemNames = [NSArray arrayWithObjects:@"Apple", @"Coffee", @"Cheese", nil];
    
    for (NSString *newItemName in newItemNames) {
        Unit *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Unit" inManagedObjectContext:_coreDataHelper.context];
        newItem.name = newItemName;
        NSLog(@"Inserted New Managed Object: %@", newItem.name);
        
    }
}

-(void)insertUnits {
    for (int i = 1; i < 5000; i++) {
        Unit *newUnit = [NSEntityDescription insertNewObjectForEntityForName:@"Unit" inManagedObjectContext:_coreDataHelper.context];
        newUnit.name = [NSString stringWithFormat:@"-->> LOTS OF TEST DATA: x%i", i];
        NSLog(@"Inserted %@", newUnit.name);
    }
    
    [_coreDataHelper saveContext];
}

- (void)demo2 {
 
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    // як забирати дані з бази в циклі
    // створюємо екземпляр класу для витягнення даних з ім’ям Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    
    
    // приклад фільтрування за допомогою створення шаблону NSFetchRequest
    // так можна робити чудові фільтри у мовних словниках
    //NSFetchRequest *request = [[[_coreDataHelper model] fetchRequestTemplateForName:@"Test"] copy];
    [request setFetchLimit:50]; // лімітування виведення об’єктів. Добре поєднується з сортуванням
    
    
    // описуємо порядок сортування результат запиту
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    // фільтруємо результат запиту за допомогою NSPredicate
    // NSPredicate *filter = [NSPredicate predicateWithFormat:@"name != %@", @"Apples"];
    // [request setPredicate:filter];
    
    // створюємо масив куди збираємо об’єкти з Entity
    NSError *error = nil;
    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
    
    if (error) {NSLog(@"%@", error);}
    else {
    
    // проходимося циклом по масиву і виводимо інформацію в лог
    //for (Measurement *measurement in fetchedObjects) {
    //    NSLog(@"Fetched Object = %@", measurement.abc);
//        [_coreDataHelper.context deleteObject:item];
        
    for (Unit *newUnit in fetchedObjects) {
    NSLog(@"Fetched Object = %@", newUnit.name);
        }
    }
}


-(void)demoMeasurementInsert {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Unit"];
    [request setFetchLimit:10];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    } else {
        for (Unit *unit in fetchedObjects) {
            NSLog(@"Fetched object = %@", unit.name);
        }
    }
}
@end
