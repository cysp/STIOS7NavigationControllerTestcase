//  Copyright (c) 2013 Scott Talbot. All rights reserved.

#import "STViewController.h"


@implementation STViewController {
@private
	BOOL _prefersNavigationBarHidden;
	UIButton *_button;
}

+ (instancetype)viewControllerWithName:(NSString *)name navigationBarHidden:(BOOL)navigationBarHidden {
	return [[self alloc] initWithNibName:nil bundle:nil name:(NSString *)name navigationBarHidden:navigationBarHidden];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil name:nil navigationBarHidden:NO];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)name navigationBarHidden:(BOOL)navigationBarHidden {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		_prefersNavigationBarHidden = navigationBarHidden;
		self.title = name;
    }
    return self;
}

- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:(CGRect){ .size = { .width = 320, .height = 480 } }];
	UIView * const view = self.view;
	CGRect const bounds = view.bounds;

	view.backgroundColor = [UIColor colorWithWhite:.75 alpha:1];

	_button = [[UIButton alloc] initWithFrame:bounds];
	_button.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	[_button setTitle:self.title ?: @"button" forState:UIControlStateNormal];
	[view addSubview:_button];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[_button addTarget:self action:@selector(performAction) forControlEvents:UIControlEventTouchUpInside];
	[_button setEnabled:[self hasAction]];
}


- (BOOL)hasAction {
	return !!_action;
}
- (void)performAction {
	dispatch_block_t action = _action;
	if (action) {
		action();
	}
}
- (void)setAction:(dispatch_block_t)action {
	_action = [action copy];
	[_button setEnabled:[self hasAction]];
}

@end
