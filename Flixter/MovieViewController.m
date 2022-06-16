//
//  MovieViewController.m
//  Flixter
//
//  Created by Ramya Prabakar on 6/15/22.
//

#import "MovieViewController.h"
#import "myTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *myArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation MovieViewController

NSArray *info;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    [self.activityIndicator startAnimating];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=9dc97edc3c5a6f1ceb43e5dd36fa6f4c"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               // TODO: Get the array of movies
               self.myArray = dataDictionary[@"results"];
               
               // TODO: Reload your table view data
               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
       }];
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.myArray[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [cell.posterImage setImageWithURL:posterURL placeholderImage:nil];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myArray.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSDictionary *dataToPass = self.myArray[[self.tableView indexPathForCell:sender].row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
}

@end
