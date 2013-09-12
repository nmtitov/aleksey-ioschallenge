//
//  TestViewController.m
//  Challenge
//
//  Created by Alexey on 12.09.13.
//  Copyright (c) 2013 Aleksey. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) BOOL sortOrder;

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sortOrder = NO;
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"SportsNews";
    NSURL *url = [NSURL URLWithString:@"http://cleverpumpkin.ru/test/5839.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSON) {
            NSArray *news = JSON[@"news"];
            self.data = [news select:^BOOL(id entry) {
                if ([entry isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = (NSDictionary *)entry;
                    
                    NSNumber *category = dict[@"category_id"];
                    return category.intValue == 208;
                }
                return false;
            }];
            [self.tableView reloadData];
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"Failure:\n%@", error.localizedDescription);
        }];
    
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = (TestCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsCell"];

    NSDictionary *entry = self.data[indexPath.row];
    cell.article = entry;
    
    return cell;
}

- (IBAction)SortButtonPressed:(id)sender{
    if (self.sortOrder == YES){
        self.sortOrder = NO;
    } else {
        self.sortOrder = YES;
    }
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"posted_time" ascending:self.sortOrder];
    NSArray *descriptorsArray = [NSArray arrayWithObjects:descriptor, nil];
    self.data = [self.data sortedArrayUsingDescriptors:descriptorsArray];
    [self.tableView reloadData];
}

@end
