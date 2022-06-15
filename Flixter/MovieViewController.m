//
//  MovieViewController.m
//  Flixter
//
//  Created by Ramya Prabakar on 6/15/22.
//

#import "MovieViewController.h"

@interface MovieViewController () <UITableViewDataSource>
@property (nonatomic, strong) NSArray *myArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MovieViewController

NSArray *info;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
               NSArray *myArray = dataDictionary[@"results"];
               
               // loop through every element in the movies array and logging it
               for (id obj in myArray) {
                   NSLog(@"%@", obj);
               }
               
               // TODO: Store the movies in a property to use elsewhere
               
               info = myArray;
               /* info = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
                            @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
                            @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
                            @"Jacksonville, FL", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
                            @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Fort Worth, TX"]; */
               
               self.tableView.dataSource = self;
               
               // TODO: Reload your table view data
           }
       }];
    [task resume];
}

/* - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = info[indexPath.row];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return info.count;
} */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
