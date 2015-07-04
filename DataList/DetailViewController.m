//
//  DetailViewController.m
//  DataList
//
//  Created by Bobby Adi Prabowo on 7/4/15.
//  Copyright (c) 2015 Bobby Adi Prabowo. All rights reserved.
//

#import "DetailViewController.h"
#import "InputViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.titleLabel.text = self.post.title;
    self.contentLabel.text = self.post.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"editPost"]) {
        InputViewController *destination = segue.destinationViewController;
        destination.post = self.post;
    }
    
}


@end
