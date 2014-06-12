//
//  BJXSearchViewController.m
//  BaiJiaXing
//
//  Created by Michael on 6/5/14.
//  Copyright (c) 2014 MichaelBai. All rights reserved.
//

#import "BJXSearchViewController.h"
#import "BJXItemViewController.h"
#import "fmdb/FMDB.h"

@interface BJXSearchViewController ()

@property NSMutableArray* searchResult;

- (void)searchFamilyname:(NSString*)str;

@end

@implementation BJXSearchViewController

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
    self.searchDisplayController.searchBar.placeholder = @"输入首字母，如搜寻\"赵\"，请输入\"z\"";
    self.searchResult = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchViewSegue"])
    {
        BJXItemViewController *viewController = [segue destinationViewController];
        NSIndexPath* indexPath = self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow;
//        NSIndexPath* indexPath = (NSIndexPath*)sender;
        NSMutableDictionary* fnDict = [self.searchResult objectAtIndex:indexPath.row];
        viewController.webContent = [fnDict objectForKey:@"description"];
        viewController.navigationItem.title = [fnDict objectForKey:@"familyname"];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    [self.searchResult addObject:searchText];
    [self searchFamilyname:searchText];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"SearchViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myIdentifier];
    }
    
    NSMutableDictionary* fnDict = [self.searchResult objectAtIndex:indexPath.row];
    cell.textLabel.text = [fnDict objectForKey:@"familyname"];
    cell.detailTextLabel.text = [fnDict objectForKey:@"pinyin"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"SearchViewSegue" sender:self];
}

- (void)searchFamilyname:(NSString*)str
{
    [self.searchResult removeAllObjects];
//    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"Database/bjx.db"];
    NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"bjx" ofType:@"db"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbpath];
    if (![db open]) {
        NSLog([NSString stringWithFormat:@"Can not open database in %@", dbpath]);
        return;
    }
    NSString* queryStr = [str stringByAppendingString:@"%"];
    FMResultSet *rs = [db executeQuery:@"select * from bjx where firstLetter like (?)", queryStr];
    while ([rs next]) {
        NSMutableDictionary* fnDict = [[NSMutableDictionary alloc] init];
        [fnDict setObject:[rs stringForColumn:@"familyname"] forKey:@"familyname"];
        [fnDict setObject:[rs stringForColumn:@"pinyin"] forKey:@"pinyin"];
        [fnDict setObject:[rs stringForColumn:@"firstLetter"] forKey:@"firstLetter"];
        [fnDict setObject:[rs stringForColumn:@"description"] forKey:@"description"];
        [self.searchResult addObject:fnDict];
    }
    [db close];
}

@end
