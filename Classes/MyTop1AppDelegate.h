//
//  MyTop1AppDelegate.h
//  MyTop1
//
//  Created by Elomar Nascimento dos Santos on 2/23/11.
//  Copyright 2011 not a serious company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTop1ViewController;

@interface MyTop1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MyTop1ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyTop1ViewController *viewController;

@end

