//
//  Address.h
//  
//
//  Created by Douglas Voss on 8/25/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSSet *residents;
@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addResidentsObject:(Person *)value;
- (void)removeResidentsObject:(Person *)value;
- (void)addResidents:(NSSet *)values;
- (void)removeResidents:(NSSet *)values;

@end
