//
//  TableViewProfileController.m
//  HotelsTasks
//
//  Created by  ZHEKA on 01.08.15.
//  Copyright (c) 2015 Pasko Eugene. All rights reserved.
//

#import "TableViewProfileController.h"
#import "HotelClass.h"
#import "HeaderCell.h"
#import "LineCell.h"
#import "UIImageView+AFNetworking.h"
#import "ServerManager.h"

@interface TableViewProfileController ()

@property (strong, nonatomic) HotelClass *hotel;

@end

@implementation TableViewProfileController

- (void) viewDidLoad {


}

-(void)setHotelSmall:(HotelSmall *)hotelSmall {
    
    _hotelSmall = hotelSmall;
    
    
    [[ServerManager sharedManager] getHotelWithID:hotelSmall.id andSuccess:^(HotelClass *hotel) {
        
        if (hotel) {
            
            self.hotel = hotel;

            [self.tableView reloadData];
            
        }



    } andFailture:^(NSError *error) {
        
        self.hotel = [[HotelClass alloc] init];
        self.hotel.photoString = @"NOT FOUND";
        [self.tableView reloadData];

    }];
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.hotel) {
        
        return 1;
    } else {
        
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        static NSString *keyHeaderCell = @"HeaderCell";
        
        HeaderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:keyHeaderCell];
        
        if (([self.hotel.photoString length] > 0) && ![self.hotel.photoString isEqualToString:@"NOT FOUND"]) {
            
            NSString *urlString = [@"https://dl.dropboxusercontent.com/u/109052005/1/" stringByAppendingString:self.hotel.photoString];
       
            NSURL *url = [NSURL URLWithString: urlString];
        
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            __weak HeaderCell *weakCell = cell;
            weakCell.photo.image = nil;

            [cell.photo setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest * request, NSHTTPURLResponse * response, UIImage * image) {
                
                [weakCell.activityView stopAnimating];
                if (image) {
                    weakCell.photo.image = image;

                } else {

                    weakCell.photo.image = [UIImage imageNamed:@"image-not-found.jpg"];
                }

                [weakCell layoutSubviews];
                
            } failure:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error) {
                
                [weakCell.activityView stopAnimating];
                weakCell.photo.image = [UIImage imageNamed:@"image-not-found.jpg"];

                [weakCell layoutSubviews];
                
            }];
            
        } else if ([self.hotel.photoString isEqualToString:@"NOT FOUND"]) {
            
            [cell.activityView stopAnimating];
            UIImage *image = [UIImage imageNamed:@"page-not-found-404.png"];
            cell.photo.image = image;
            
        } else {
            
            [cell.activityView stopAnimating];
            UIImage *image = [UIImage imageNamed:@"image-not-found.jpg"];
            cell.photo.image = image;
        }
        

        
        return cell;
    } else {
        
        static NSString *keyCell = @"LineCell";
        
        LineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:keyCell];
        
        if (indexPath.row == 1) {
            cell.firstLabel.text = @"Name:";
            cell.secondLabel.text = self.hotel.name;
        } else if (indexPath.row == 2) {
            
            cell.firstLabel.text = @"Address:";
            cell.secondLabel.text = self.hotel.address;
        } else if (indexPath.row == 3) {
            
            cell.firstLabel.text = @"Stars:";
            cell.secondLabel.text = [@(self.hotel.stars) stringValue];
        } else if (indexPath.row == 4) {
            
            cell.firstLabel.text = @"Distance:";
            NSString *distanceString = [NSString stringWithFormat:@"%1.2f", self.hotel.distance];
            cell.secondLabel.text = distanceString;
        } else if (indexPath.row == 5) {
            
            cell.firstLabel.text = @"Suites Availability:";
            cell.secondLabel.text = self.hotel.suites_availability;
        }
        
        
        return cell;
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 ) {
        
        return 200;
    } else {
        
        return 56;
    }
}

#pragma mark - UITableViewDelegate -


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
