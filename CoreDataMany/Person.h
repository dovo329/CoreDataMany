//
//  Person.h
//  
//
//  Created by Douglas Voss on 8/25/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSSet *places;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addPlacesObject:(Address *)value;
- (void)removePlacesObject:(Address *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

@end
