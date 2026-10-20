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
    UIWindowScene *windowScene = (UIWindowScene *)scene;

    // External display scenes are owned by ExternalDisplayManager, which creates
    // the dedicated monitor window (with the AVSampleBufferDisplayLayer) and
    // attaches it to this scene via initWithWindowScene:. Loading the storyboard
    // here would put a second, mirrored copy of the main UI on the monitor.
    if (windowScene.screen != [UIScreen mainScreen]) {
        return;
    }

    // Main screen: load the correct storyboard for the current device idiom,
    // mirroring the old UIMainStoryboardFile / UIMainStoryboardFile~ipad keys.
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];

    NSString *storyboardName = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"iPad" : @"iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

    window.rootViewController = [storyboard instantiateInitialViewController];

    self.window = window;
    [window makeKeyAndVisible];
}

@end