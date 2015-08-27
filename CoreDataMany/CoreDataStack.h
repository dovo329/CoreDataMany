//
//  CoreDataStack.h
//  CoreDataMany
//
//  Created by Douglas Voss on 8/26/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface CoreDataStack : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSPersistentStoreCoordinator *psc;
@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSPersistentStore *store;

@property (nonatomic, strong) NSURL *documentsURL;
@property (nonatomic, strong) NSURL *storeURL;

+ (NSURL *) applicationDocumentsDirectory;

@end
