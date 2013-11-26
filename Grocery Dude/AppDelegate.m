//
//  AppDelegate.m
//  Grocery Dude
//
//  Created by Anvar Azizov on 2013-11-17.
//  Copyright (c) 2013 Anvar Azizov. All rights reserved.
//

#import "AppDelegate.h"
#import "Item.h"
#import "Unit.h"
#import "LocationAtShop.h"
#import "LocationAtHome.h"

@implementation AppDelegate

#define debug 1

- (CoreDataHelper *)cdh {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    // створюємо екземпляр класу лише один раз
    if (!_coreDataHelper) {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            _coreDataHelper = [CoreDataHelper new];
        });
        
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
    
//    [self cdh];
    [self demo];
}

-(void)demo {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    
    CoreDataHelper *cdh = [self cdh];
    NSArray *homeLocations = [NSArray arrayWithObjects:@"Fruit Bowl", @"Pantry", @"Nursery", @"Bathroom", @"Fridge", nil];
    
    NSArray *shopLocations = [NSArray arrayWithObjects:@"Produce", @"Aisle 1", @"Aisle 2", @"Aisle 3", @"Deli", nil];
    
    NSArray *unitNames = [NSArray arrayWithObjects:@"g", @"pkt", @"box", @"ml", @"kg", nil];
    
    NSArray *itemNames = [NSArray arrayWithObjects:@"Grapes", @"Biscuits", @"Nappies", @"Shampoo", @"Potatoes", nil];
    
    int i = 0;
    
    for (NSString *itemName in itemNames) {
        LocationAtHome *locationAtHome = [NSEntityDescription insertNewObjectForEntityForName:@"LocationAtHome" inManagedObjectContext:cdh.context];
        LocationAtShop *locationAtShop = [NSEntityDescription insertNewObjectForEntityForName:@"LocationAtShop" inManagedObjectContext:cdh.context];
        Unit *unit = [NSEntityDescription insertNewObjectForEntityForName:@"Unit" inManagedObjectContext:cdh.context];
        Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:cdh.context];
        
        locationAtHome.storedIn = [homeLocations objectAtIndex:i];
        locationAtShop.aisle = [shopLocations objectAtIndex:i];
        unit.name = [unitNames objectAtIndex:i];
        item.name = [itemNames objectAtIndex:i];
        
        item.locationAtHome = locationAtHome;
        item.locationAtShop = locationAtShop;
        item.unit = unit;
        
        i++;
    }
    [cdh saveContext];
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

-(void)insertExample {
    
    // створюємо 2 екземпляри класу Item: ручку та олівець
    Item *pen = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[[self cdh] context]];
    Item *pencil = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[[self cdh] context]];
    
    // створюємо екземпляр класу розташування в магазині
    LocationAtShop *shopLocation = [NSEntityDescription insertNewObjectForEntityForName:@"LocationAtShop" inManagedObjectContext:[[self cdh] context]];
    
    // створюємо екземпляр класу розташування вдома
    LocationAtHome *homeLocation = [NSEntityDescription insertNewObjectForEntityForName:@"LocationAtHome" inManagedObjectContext:[[self cdh] context]];
    
    // створюємо атрибути name для екземплярів класу Item
    pen.name = [NSString stringWithFormat:@"Black pen"];
    pencil.name = [NSString stringWithFormat:@"Green pencil"];
    
    // створюємо атрибути storedIn та aisle відповідно для екземплярів класів LocationAtHome та LocationAtShop
    homeLocation.storedIn = [NSString stringWithFormat:@"Box"];
    shopLocation.aisle = [NSString stringWithFormat:@"Aisle 4"];
    
    // говоримо програмі де саме розташовані екземпляри класу: вдома чи у крамниці
    shopLocation.items = [[NSSet alloc] initWithObjects:pen, pencil, nil];
    homeLocation.items = [[NSSet alloc] initWithObjects:pencil, nil];
    
    // виводимо в лог розташування предметів у локаціях
    NSLog(@"At the %@ we can find a %@ and a %@. But in the %@ only %@ present, really, cause pen.locationAtHome.storedIn is null, look: %@", pen.locationAtShop.aisle, pen.name, pencil.name, pencil.locationAtHome.storedIn, pencil.name, pen.locationAtHome.storedIn);
    
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

-(void)deleteUnit {
    if (debug == 1) {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }

    // створюємо екземпляр класу для витягнення даних з ім’ям Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"LocationAtShop"];
    NSError *error = nil;
    
    // створюємо масив куди збираємо об’єкти з Entity
    NSArray *fetchedObjects = [_coreDataHelper.context executeFetchRequest:request error:&error];
    
    for (LocationAtShop *loc in fetchedObjects) {
    NSLog(@"Fetched Object = %@", loc.aisle);
    [_coreDataHelper.context deleteObject:loc];
    }
    [_coreDataHelper saveContext];
}
@end
