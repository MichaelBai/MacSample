//
//  BJXTableViewController.m
//  BaiJiaXing
//
//  Created by Michael on 5/19/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import "BJXTableViewController.h"
#import "BJXItemViewController.h"
#import "fmdb/FMDB.h"

@interface BJXTableViewController ()

@property NSMutableDictionary* familyDict;
@property NSArray* sortedPinyinKeys;

@end

@implementation BJXTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"Database/bjx.db"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from bjx"];
    self.familyDict = [[NSMutableDictionary alloc] init];
    while ([rs next]) {
        NSString* firstLetter = [[rs stringForColumn:@"firstLetter"] substringToIndex:1];
        if ([self.familyDict objectForKey:firstLetter] == nil) {
            NSMutableArray* fnArr = [[NSMutableArray alloc] init];
            [self.familyDict setObject:fnArr forKey:firstLetter];
        }
        NSMutableArray* fnArr = [self.familyDict objectForKey:firstLetter];
        NSMutableDictionary* fnDict = [[NSMutableDictionary alloc] init];
        [fnDict setObject:[rs stringForColumn:@"familyname"] forKey:@"familyname"];
        [fnDict setObject:[rs stringForColumn:@"pinyin"] forKey:@"pinyin"];
        [fnDict setObject:[rs stringForColumn:@"firstLetter"] forKey:@"firstLetter"];
        [fnDict setObject:[rs stringForColumn:@"description"] forKey:@"description"];
        [fnArr addObject:fnDict];
    }
    [db close];
    
    self.sortedPinyinKeys = [[self.familyDict allKeys] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sortedPinyinKeys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sortedPinyinKeys objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.familyDict objectForKey:[self.sortedPinyinKeys objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    
    NSMutableDictionary* fnArr = [[self.familyDict objectForKey:[self.sortedPinyinKeys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [fnArr objectForKey:@"familyname"];
    cell.detailTextLabel.text = [fnArr objectForKey:@"pinyin"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"itemViewSegue" sender:self];
}

// Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    return self.sortedPinyinKeys;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    // tell table which section corresponds to section title/index (e.g. "B",1))
    return index;
}


- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"itemViewSegue"])
    {
        BJXItemViewController *viewController = [segue destinationViewController];
        NSMutableDictionary* fnArr = [[self.familyDict objectForKey:[self.sortedPinyinKeys objectAtIndex:[self.tableView indexPathForSelectedRow].section]] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        viewController.webContent = [fnArr objectForKey:@"description"];
        viewController.navigationItem.title = [fnArr objectForKey:@"familyname"];
    }
}

@end
