//
//  TableViewController.m
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "TableViewController.h"
#import "ServerManager.h"
#import "HotelCell.h"
#import "HotelSmall.h"
#import "TableViewProfileController.h"

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray *hotels;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;

@end

@implementation TableViewController

-(void) viewDidLoad {
    
    self.hotels = [NSMutableArray array];
    
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(generateHotels) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = control;
    
    [self generateHotels];
}

#pragma mark - Actions -

- (IBAction)changeSegmentAction:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        [self.hotels sortUsingDescriptors:@[descriptor]];
    } else {
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"freeNumbers" ascending:NO];
        [self.hotels sortUsingDescriptors:@[descriptor]];
    }
    
    [self.tableView reloadData];
}

- (void) generateHotels {
    
    [[ServerManager sharedManager] getHotelsArrayWithSuccess:^(NSMutableArray *array) {
        
        self.hotels = [NSMutableArray array];
        
        [self.hotels addObjectsFromArray:array];
        
        if (self.segControl.selectedSegmentIndex == 0) {
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
            [self.hotels sortUsingDescriptors:@[descriptor]];
        } else {
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"freeNumbers" ascending:NO];
            [self.hotels sortUsingDescriptors:@[descriptor]];
        }
        
        [self.refreshControl endRefreshing];
        
        [self.tableView reloadData];
        
    } andFailture:nil];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.hotels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *keyHotel = @"HotelCell";
    
    HotelCell *cell = [self.tableView dequeueReusableCellWithIdentifier:keyHotel];
    
    HotelSmall *hotel = [self.hotels objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = hotel.name;
    cell.distanceLabel.text = [@(hotel.distance) stringValue];
    cell.freeLabel.text = [@(hotel.freeNumbers) stringValue];
    
    return cell;
}

#pragma mark - UITableViewDelegate -


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableViewProfileController *vc = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"TableViewProfileController"];
    vc.hotelSmall = [self.hotels objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
