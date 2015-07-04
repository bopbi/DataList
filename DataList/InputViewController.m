//
//  InputViewController.m
//  DataList
//
//  Created by Bobby Adi Prabowo on 7/4/15.
//  Copyright (c) 2015 Bobby Adi Prabowo. All rights reserved.
//

#import "InputViewController.h"
#import <MagicalRecord/MagicalRecord.h>

@interface InputViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic) BOOL isNew;
@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNew = YES;
    if (self.post) {
        self.isNew = false;
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    if (self.isNew) {
        self.title = @"Add New Post";
    } else {
        self.title = @"Edit Post";
        self.titleTextField.text = self.post.title;
        self.contentTextField.text = self.post.content;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTouched:(id)sender {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Post *post;
        if (self.isNew) {
            post = [Post MR_createEntityInContext:localContext];
        } else {
            post = self.post;
        }
        
        post.title = self.titleTextField.text;
        post.content = self.contentTextField.text;

    } completion:^(BOOL contextDidSave, NSError *error) {
        if (self.isNew) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
}

- (IBAction)cancelButtonTouched:(id)sender {
    if (self.isNew) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
