//
//  RootViewController.m
//  BouncyParallax
//
//  Created by Hamed Hashemi on 12/5/13.
//  Copyright (c) 2013 Hamed Hashemi. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "BouncyParallaxViewController.h"
#import "TopCell.h"

#define BOUNCY_IMAGE_HEIGHT 200

@interface BouncyParallaxViewController ()

@end

@implementation BouncyParallaxViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame: [UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor clearColor];
    self.view.clipsToBounds = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[TopCell class] forCellReuseIdentifier:@"TopCell"];
    [self.view addSubview:tableView];
    
    self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BOUNCY_IMAGE_HEIGHT)];
    self.topImage.contentMode = UIViewContentModeScaleAspectFill;
    self.topImage.clipsToBounds = YES;
    self.topImage.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.topImage atIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topImage.image = [UIImage imageNamed:@"sample"];
}

- (void)didReceiveMemoryWarning {
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return BOUNCY_IMAGE_HEIGHT;
    }
    else {
        return 44;
    }
}

- (UITableViewCell*)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TopCell *cell = [table dequeueReusableCellWithIdentifier:@"TopCell" forIndexPath:indexPath];
        return cell;
    }
    else {
        UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"SampleCell"];
        if (cell == NULL) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SampleCell"];
        }
        return cell;
    }
    return NULL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        return 20;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        self.topImage.frame = CGRectMake(scrollView.contentOffset.y / 2, 0, self.view.frame.size.width - scrollView.contentOffset.y, BOUNCY_IMAGE_HEIGHT -scrollView.contentOffset.y);
    }
    else {
        self.topImage.frame = CGRectMake(0, -scrollView.contentOffset.y / 3, self.view.frame.size.width, BOUNCY_IMAGE_HEIGHT);
    }
}

@end
