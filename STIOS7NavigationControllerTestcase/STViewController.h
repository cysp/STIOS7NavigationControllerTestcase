//  Copyright (c) 2013 Scott Talbot. All rights reserved.

#import <UIKit/UIKit.h>


@interface STViewController : UIViewController
+ (instancetype)viewControllerWithName:(NSString *)name navigationBarHidden:(BOOL)navigationBarHidden;
@property (nonatomic,assign,readonly) BOOL prefersNavigationBarHidden;
@property (nonatomic,copy) dispatch_block_t action;
@end
