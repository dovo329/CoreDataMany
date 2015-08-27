//
//  CoreDataStack.m
//  CoreDataMany
//
//  Created by Douglas Voss on 8/26/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()

@end

@implementation CoreDataStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *url = [bundle URLForResource:@"CoreDataMany" withExtension:@"momd"];
        
        self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
        self.psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        self.context = [[NSManagedObjectContext alloc] init];
        self.context.persistentStoreCoordinator = self.psc;
        
        self.documentsURL = [CoreDataStack applicationDocumentsDirectory];
        self.storeURL = [self.documentsURL URLByAppendingPathComponent:@"CoreDataMany"];
        NSDictionary* options = @{NSMigratePersistentStoresAutomaticallyOption : @YES};
        
        NSError *error;
        self.store = [self.psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:options error:&error];
        
        if (self.store == nil) {
            NSLog(@"Error adding persistent store: \(error)");
            abort();
        }
    }
    return self;
}

+ (NSURL *) applicationDocumentsDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    
    NSURL *url = urls[0];
    return url;
}

- (void)saveContext {
    NSError *error;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Could not save: %@, %@", error, [error userInfo]);
    }
}

@end
