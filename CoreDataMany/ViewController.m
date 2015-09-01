//
//  ViewController.m
//  CoreDataMany
//
//  Created by Douglas Voss on 8/25/15.
//  Copyright (c) 2015 VossWareLLC. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataStack.h"
#import "Person.h"
#import "Address.h"
#import "PersonCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CoreDataStack *coreDataStack;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *personArray;
@property (nonatomic, strong) NSMutableArray *addressArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.coreDataStack = [[CoreDataStack alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[PersonCell class] forCellReuseIdentifier:kPersonCellId];
    [self tableViewConstraints];
    
    self.personArray = [NSMutableArray new];
    self.addressArray = [NSMutableArray new];
    
    NSEntityDescription *personEntity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.coreDataStack.context];
    
    NSFetchRequest *personFetchRequest = [[NSFetchRequest alloc] init];
    [personFetchRequest setEntity:personEntity];
    
    NSError *error = nil;
    
    NSArray *result = [self.coreDataStack.context executeFetchRequest:personFetchRequest error:&error];
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        for (int i=0; i<[result count]; i++) {
            Person *person = result[i];
            [self.personArray addObject:person];
        }
    }
    
    NSEntityDescription *addressEntity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:self.coreDataStack.context];
    
    NSFetchRequest *addressFetchRequest = [[NSFetchRequest alloc] init];
    [addressFetchRequest setEntity:addressEntity];
    
    result = [self.coreDataStack.context executeFetchRequest:addressFetchRequest error:&error];
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        for (int i=0; i<[result count]; i++) {
            Address *address = result[i];
            [self.addressArray addObject:address];
        }
    }
}

- (void)tableViewConstraints {
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:
     [NSLayoutConstraint
      constraintWithItem:self.tableView
      attribute:NSLayoutAttributeLeft
      relatedBy:NSLayoutRelationEqual
      toItem:self.view
      attribute:NSLayoutAttributeLeft
      multiplier:1.0
      constant:0.0]];
    [self.view addConstraint:
     [NSLayoutConstraint
      constraintWithItem:self.tableView
      attribute:NSLayoutAttributeRight
      relatedBy:NSLayoutRelationEqual
      toItem:self.view
      attribute:NSLayoutAttributeRight
      multiplier:1.0
      constant:0.0]];
    [self.view addConstraint:
     [NSLayoutConstraint
      constraintWithItem:self.tableView
      attribute:NSLayoutAttributeTop
      relatedBy:NSLayoutRelationEqual
      toItem:self.topLayoutGuide
      attribute:NSLayoutAttributeBottom
      multiplier:1.0
      constant:0.0]];
    [self.view addConstraint:
     [NSLayoutConstraint
      constraintWithItem:self.tableView
      attribute:NSLayoutAttributeBottom
      relatedBy:NSLayoutRelationEqual
      toItem:self.view
      attribute:NSLayoutAttributeBottom
      multiplier:1.0
      constant:0.0]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonCellId];
    
    if (indexPath.section == 0) {
        Person *person = self.personArray[indexPath.row];
        cell.textLabel.text = person.name;
        cell.detailTextLabel.text = person.gender;
    } else {
        Address *address = self.addressArray[indexPath.row];
        cell.textLabel.text = address.city;
        cell.detailTextLabel.text = address.state;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.personArray count];
    } else {
        return [self.addressArray count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Persons";
    } else {
        return @"Addresses";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
