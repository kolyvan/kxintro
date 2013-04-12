//
//  AppDelegate.m
//  KxIntroExample
//
//  Created by Kolyvan on 11.04.13.
//  Copyright (c) 2013 Konstantin Bukreev. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "KxIntroViewController.h"
#import "KxIntroViewPage.h"
#import "KxIntroView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    [self showIntro];    
    return YES;
}

- (void) showIntro
{    
    KxIntroViewPage *page0 = [KxIntroViewPage introViewPageWithTitle: @"Hello from SampleApp"
                                                          withDetail: @"Look at this example of using the intro screen! Gradient background, full screen support and more."
                                                           withImage: [UIImage imageNamed:@"sun"]];
    
    KxIntroViewPage *page1 = [KxIntroViewPage introViewPageWithTitle: @"What's new"
                                                          withDetail: @"List of new features\n\n- feature #1\n- feature #2\n- feature #3\n- feature #4\n- feature #5"
                                                           withImage: [UIImage imageNamed:@"tor"]];
    
    KxIntroViewPage *page2 = [KxIntroViewPage introViewPageWithTitle: @"Lorem Ipsum passage"
                                                          withDetail: @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum!"
                                                           withImage: nil];
    
    page1.detailLabel.textAlignment = NSTextAlignmentLeft;
    
    KxIntroViewController *vc = [[KxIntroViewController alloc ] initWithPages:@[ page0, page1, page2 ]];
    
    // sample using header
    if (0) {
        
        const BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
        
        UIFont *font = [UIFont boldSystemFontOfSize:isPhone ? 22 : 26];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, isPhone ? 10 : 25, 0, font.lineHeight)];
        label.text = @"Sample App";
        label.font = font;
        label.textColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.opaque = NO;
        label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, font.lineHeight + (isPhone ? 10 : 25))];
        header.backgroundColor = [UIColor clearColor];
        header.opaque = NO;
        [header addSubview:label];
        
        vc.introView.introHeader = header;
    }
    
    vc.introView.animatePageChanges = YES;
    vc.introView.gradientBackground = YES;
    
    //[vc presentInView:self.window.rootViewController.view];
    [vc presentInViewController:self.window.rootViewController fullScreenLayout:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
