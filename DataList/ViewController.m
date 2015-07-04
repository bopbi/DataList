//
//  ViewController.m
//  DataList
//
//  Created by Bobby Adi Prabowo on 7/3/15.
//  Copyright (c) 2015 Bobby Adi Prabowo. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "InputViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Post.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.posts = [[NSMutableArray alloc] initWithArray:[Post MR_findAll]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.posts) {
        return self.posts.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    titleLabel.text = [[self.posts objectAtIndex:indexPath.row] title];
    
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:102];
    contentLabel.text = [[self.posts objectAtIndex:indexPath.row] content];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Post *post = (Post *)[self.posts objectAtIndex:indexPath.row];
        NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
        [post MR_deleteEntityInContext:context];
        
        [self.posts removeObjectAtIndex:indexPath.row];
        [context MR_saveToPersistentStoreAndWait];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showPost"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Post *post = self.posts[indexPath.row];
        DetailViewController *destination = segue.destinationViewController;
        destination.post = post;
    }
}


@end
