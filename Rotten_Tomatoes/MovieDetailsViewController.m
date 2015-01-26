//
//  MovieDetailsViewController.m
//  Rotten_Tomatoes
//
//  Created by Nadav Golbandi on 1/24/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Details";
    NSString* lawRes = [self.movie valueForKeyPath:@"posters.thumbnail"];
    [self.movieImage setImageWithURL:[NSURL URLWithString: lawRes]];

    NSString* imageUrl = [lawRes stringByReplacingOccurrencesOfString:@"_tmb" withString:@"_ori"];    
    [self.movieImage setImageWithURL:[NSURL URLWithString: imageUrl]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.movie[@"title"], self.movie[@"year"]];
    self.synopsisLabel.text = self.movie[@"synopsis"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
