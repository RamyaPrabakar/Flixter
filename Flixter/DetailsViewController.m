//
//  DetailsViewController.m
//  Flixter
//
//  Created by Ramya Prabakar on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.moveTitleLabel.text = self.detailDict[@"title"];
    self.movieDescriptionLabel.text = self.detailDict[@"overview"];
    
    // setting the poster image
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.detailDict[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    
    // setting the backdrop image
    NSString *backDropURLString = self.detailDict[@"backdrop_path"];
    NSString *fullBackDropURLString = [baseURLString stringByAppendingString:backDropURLString];
    NSURL *backDropURL = [NSURL URLWithString:fullBackDropURLString];

    
    [self.bigPosterImage setImageWithURL:backDropURL placeholderImage:nil];
    [self.smallPosterImage setImageWithURL:posterURL placeholderImage:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
