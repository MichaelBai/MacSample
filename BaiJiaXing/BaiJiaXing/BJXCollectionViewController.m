//
//  BJXCollectionViewController.m
//  BaiJiaXing
//
//  Created by Michael on 6/3/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import "BJXCollectionViewController.h"
#import "BJXItemViewController.h"
#import "fmdb/FMDB.h"

@interface BJXCollectionViewController ()

@property NSArray* testData;
@property NSMutableArray* familyArr;

@end

@implementation BJXCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"Database/bjx.db"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from bjx"];
    self.familyArr = [[NSMutableArray alloc] init];
    while ([rs next]) {
//        [self.familyDict setObject:[rs stringForColumn:@"description"] forKey:[rs stringForColumn:@"familyname"]];
        NSMutableDictionary* fnDict = [[NSMutableDictionary alloc] init];
        [fnDict setObject:[rs stringForColumn:@"familyname"] forKey:@"familyname"];
        [fnDict setObject:[rs stringForColumn:@"pinyin"] forKey:@"pinyin"];
        [fnDict setObject:[rs stringForColumn:@"firstLetter"] forKey:@"firstLetter"];
        [fnDict setObject:[rs stringForColumn:@"description"] forKey:@"description"];
        [self.familyArr addObject:fnDict];
    }
    [db close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CollectionCellView"])
    {
        BJXItemViewController *viewController = [segue destinationViewController];
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        
        NSString* btTitle = [[self.familyArr objectAtIndex:indexPath.row] objectForKey:@"familyname"];
        viewController.navigationItem.title = btTitle;
        viewController.webContent = [[self.familyArr objectAtIndex:indexPath.row] objectForKey:@"description"];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.familyArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CollectionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel* label = (UILabel*)[cell viewWithTag:100];
    
    NSString* fn = [[self.familyArr objectAtIndex:indexPath.row] objectForKey:@"familyname"];
    label.text = fn;
    
    return cell;
}

@end
