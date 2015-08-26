//
//  AppDelegate.m
//  CoreDataMany
//
//  Created by Douglas Voss on 8/25/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

#import "AppDelegate.h"
#import "Address.h"
#import "Person.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

//#define REMAKE_DB

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSEntityDescription *personEntity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    
    NSEntityDescription *addressEntity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    
#ifdef REMAKE_DB
    Person *person1 = [[Person alloc] initWithEntity:personEntity insertIntoManagedObjectContext:self.managedObjectContext];
    Person *person2 = [[Person alloc] initWithEntity:personEntity insertIntoManagedObjectContext:self.managedObjectContext];
    Person *person3 = [[Person alloc] initWithEntity:personEntity insertIntoManagedObjectContext:self.managedObjectContext];
    
    Address *address1 = [[Address alloc] initWithEntity:addressEntity insertIntoManagedObjectContext:self.managedObjectContext];
    Address *address2 = [[Address alloc] initWithEntity:addressEntity insertIntoManagedObjectContext:self.managedObjectContext];
    Address *address3 = [[Address alloc] initWithEntity:addressEntity insertIntoManagedObjectContext:self.managedObjectContext];
    
    person1.name = @"Guy McShneezagin";
    person1.age = [NSNumber numberWithDouble:32.1];
    person1.gender = @"Male";
    person1.places = [[NSSet alloc] initWithObjects:address1, address2, nil];
    
    person2.name = @"Barak Obama";
    person2.age = [NSNumber numberWithDouble:54];
    person2.gender = @"Male";
    person2.places = [[NSSet alloc] initWithObjects:address3, nil];
    
    person3.name = @"Michelle Obama";
    person3.age = [NSNumber numberWithDouble:51];
    person3.gender = @"Female";
    person3.places = [[NSSet alloc] initWithObjects:address3, nil];

    address1.street = @"123 Nowhere Street";
    address1.city = @"McFeelyVille";
    address1.state = @"Moldova";
    address1.zip = @"90210";
    address1.residents = [[NSSet alloc] initWithObjects:person1, nil];
    
    address2.street = @"25 Jumpy Street";
    address2.city = @"Duckberg";
    address2.state = @"Mallard";
    address2.zip = @"11111";
    address2.residents = [[NSSet alloc] initWithObjects:person1, nil];
    
    address3.street = @"1600 Pennsylvania Ave NW";
    address3.city = @"Washington, DC";
    address3.state = @"Washington, DC";
    address3.zip = @"20006";
    address3.residents = [[NSSet alloc] initWithObjects:person2, person3, nil];
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"managed Object Context save error %@", error);
    } else {
        NSLog(@"save was a success");
    }
    NSLog(@"app dir: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
#endif
    
    NSFetchRequest *personFetchRequest = [[NSFetchRequest alloc] init];
    [personFetchRequest setEntity:personEntity];
    
    NSFetchRequest *addressFetchRequest = [[NSFetchRequest alloc] init];
    [addressFetchRequest setEntity:addressEntity];
    
    //NSArray *result = [self.managedObjectContext executeFetchRequest:personFetchRequest error:&error];
    NSArray *result = [self.managedObjectContext executeFetchRequest:addressFetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        for (int i=0; i<[result count]; i++) {
            NSLog(@"[%d] fetch result before property access: %@", i, result[i]);
            Address *address = result[i];
            //NSLog(@"address[%d] property access street: %@", i, address.street);
            NSArray *residents = [address.residents allObjects];
            
            for (int j=0; j< [residents count]; j++) {
                Person *person = residents[j];
                NSLog(@"before address[%d] property access relationship person[%d]: %@", i, j, person);
                NSLog(@"address[%d] property access relationship person[%d].name: %@", i, j, person.name);
                NSLog(@"after address[%d] property access relationship person[%d]: %@", i, j, person);
            }
            
            NSLog(@"[%d] fetch result after property access: %@", i, result[i]);
        }

    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.vosswarellc.ios.CoreDataMany" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataMany" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataMany.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
