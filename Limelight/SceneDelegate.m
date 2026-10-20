//
//  SceneDelegate.m
//  Moonlight
//
//  Scene-based replacement for the legacy "storyboard loads the window"
//  behaviour. Loads the same iPhone/iPad storyboard as the initial
//  view controller, so the rest of the app is untouched.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow
    // to the provided UIWindowScene.
    UIWindowScene *windowScene = (UIWindowScene *)scene;

    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];

    // Load the correct storyboard for the current device idiom,
    // mirroring the old UIMainStoryboardFile / UIMainStoryboardFile~ipad keys.
    NSString *storyboardName = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"iPad" : @"iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

    window.rootViewController = [storyboard instantiateInitialViewController];

    self.window = window;
    [window makeKeyAndVisible];
}

@end