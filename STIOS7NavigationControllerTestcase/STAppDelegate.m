//  Copyright (c) 2013 Scott Talbot. All rights reserved.

#import "STAppDelegate.h"

#import "STViewController.h"


@protocol STViewController <NSObject>
@optional
- (BOOL)prefersNavigationBarHidden;
@end
@interface UIViewController () <STViewController>
@end


@interface STAppDelegate () <UINavigationControllerDelegate>
@end

@implementation STAppDelegate

- (void)setWindow:(UIWindow *)window {
	_window = window;
	[_window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.backgroundColor = [UIColor blackColor];
	self.window = window;

	UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:nil toolbarClass:nil];
	navController.delegate = self;
	window.rootViewController = navController;

	STViewController *a = [STViewController viewControllerWithName:@"A" navigationBarHidden:YES];
	STViewController *b = [STViewController viewControllerWithName:@"B" navigationBarHidden:NO];
	STViewController *c = [STViewController viewControllerWithName:@"C" navigationBarHidden:YES];
	STViewController *d = [STViewController viewControllerWithName:@"D" navigationBarHidden:NO];

	__weak UINavigationController *wnc = navController;
	dispatch_block_t actionPop = ^{
		[wnc popViewControllerAnimated:YES];
	};
	dispatch_block_t actionPushB = ^{
		[wnc pushViewController:b animated:YES];
	};
	dispatch_block_t actionPushC = ^{
		[wnc pushViewController:c animated:YES];
	};
	dispatch_block_t actionPushD = ^{
		[wnc pushViewController:d animated:YES];
	};

	a.action = ^{
		b.action = actionPushC;
		c.action = actionPushD;
		actionPushB();
	};
	d.action = ^{
		c.action = actionPop;
		b.action = actionPop;
		actionPop();
	};

	[navController setViewControllers:@[ a ] animated:NO];

    return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	BOOL navigationBarHidden = NO;
	if ([viewController respondsToSelector:@selector(prefersNavigationBarHidden)]) {
		navigationBarHidden = [viewController prefersNavigationBarHidden];
	}
	[navigationController setNavigationBarHidden:navigationBarHidden animated:animated];
}

@end
