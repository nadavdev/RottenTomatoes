//
//  MoviesViewController.m
//  Rotten_Tomatoes
//
//  Created by Nadav Golbandi on 1/23/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "SVProgressHUD.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* movies;
@property (nonatomic, strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property BOOL isRequestActive;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self pullRemoteInfo];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 125;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    //adding ui refresh controller
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.loadingView startAnimating];
    self.loadingView.center = tableFooterView.center;
    [tableFooterView addSubview:self.loadingView];
    self.tableView.tableFooterView = tableFooterView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //we are in the last cell
//    if (indexPath.row == self.movies.count-1 && self.isRequestActive == FALSE) {
//        [self pullRemoteInfo];
//        [self.loadingView stopAnimating];
//        [self.tableView reloadData ];
//        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [self.tableView selectRowAtIndexPath:0 animated:YES
//                              scrollPosition:UITableViewScrollPositionTop];
//    }
    self.title = @"Movies";
    MovieCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary* movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    [cell.posterView setImageWithURL:[NSURL URLWithString: [movie valueForKeyPath:@"posters.thumbnail"]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailsViewController* vc = [[MovieDetailsViewController alloc] init];
    vc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onRefresh {
    [self pullRemoteInfo];
    [self.refreshControl endRefreshing];
}


- (void) pullRemoteInfo{
    [SVProgressHUD show];
    self.isRequestActive = TRUE;
    //    NSURL * url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&country=us"];
    NSURL * url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=u343amyrthcbeqdtj9nart99"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"Response %@", responseDictionary);
        [SVProgressHUD dismiss];
        self.movies = responseDictionary[@"movies"];
        [self.tableView reloadData];
    }];
    self.isRequestActive = FALSE;
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
