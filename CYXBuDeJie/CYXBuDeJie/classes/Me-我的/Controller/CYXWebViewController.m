//
//  CYXWebViewController.m
//  CYXBuDeJie
//
//  Created by Macx on 15/10/12.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXWebViewController.h"

@interface CYXWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CYXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
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
