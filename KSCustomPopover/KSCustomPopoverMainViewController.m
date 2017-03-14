//
//  KSCustomPopoverMainViewController.m
//  KSCustomPopover
//
//  Created by Krzysztof Scianski on 12.02.2012.
//  Copyright (c) 2012 Krzysztof Scianski. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "KSCustomPopoverMainViewController.h"
#import "KSCustomPopoverBackgroundView.h"

#define CUSTOM_POPOVER_BACKGROUND NO
#define USE_DIM_BACKGROUND_VIEW YES

@interface KSCustomPopoverMainViewController ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIBarButtonItem *bbItem;
@property (nonatomic, strong) UIView *dimView;
@end

@implementation KSCustomPopoverMainViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupPopoverTest];
}

#pragma mark - Flipside View Controller

- (void) _setupPopoverTest {
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 75, 20)];
    self.bbItem = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    [self.button setTitle:@"Popover" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(showPopover) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:self.bbItem animated:false];
}

- (void)showPopover {
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationPopover;
    vc.view.backgroundColor = [UIColor magentaColor];
    vc.preferredContentSize = CGSizeMake(200, 200);
    vc.popoverPresentationController.delegate = self;
    
    if (CUSTOM_POPOVER_BACKGROUND) {
        vc.popoverPresentationController.popoverBackgroundViewClass = [KSCustomPopoverBackgroundView class];
    }
    
    if (USE_DIM_BACKGROUND_VIEW) {
        [self _showDimView];
    }
    
    [self presentViewController:vc animated:false completion:nil];
    
    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    vc.popoverPresentationController.barButtonItem = self.bbItem;
}

- (void)_showDimView {
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    UIView *rootView = delegate.window.rootViewController.view;
    self.dimView = [[UIView alloc] initWithFrame:rootView.bounds];
    self.dimView.backgroundColor = [UIColor blackColor];
    self.dimView.alpha = 0;
    [rootView addSubview:self.dimView];
    
    __weak KSCustomPopoverMainViewController *weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.dimView.alpha = 0.5;
    }];
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    if (USE_DIM_BACKGROUND_VIEW) {
        //You may expect we would dismiss the dimView in popoverPresentationControllerDidDismissPopover
        //I'm dismissing it here instead so that it doesn't have to wait for the popover to disappear before it animates away
        
        __weak KSCustomPopoverMainViewController *weakSelf = self;
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.dimView.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf.dimView removeFromSuperview];
            weakSelf.dimView = nil;
        }];
    }
    
    return YES;
}

-(UIModalPresentationStyle) adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
