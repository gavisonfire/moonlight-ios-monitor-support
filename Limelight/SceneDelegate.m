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
    if (![scene isKindOfClass:[UIWindowScene class]]) {
        return;
    }
    UIWindowScene *windowScene = (UIWindowScene *)scene;

    // Only the application-role scene carries the app UI. External display
    // scenes (role UIWindowSceneSessionRoleExternalDisplay) are owned by
    // ExternalDisplayManager, which creates its own window + video layer.
    // Checking the scene role is more reliable than comparing UIScreen
    // identities, which misbehave once the app supports all orientations.
    if (session.role != UIWindowSceneSessionRoleApplication) {
        Log(LOG_I, @"SCENE skip non-application role (external display?) screen=%@", windowScene.screen);
        return;
    }

    Log(LOG_I, @"SCENE willConnect role=%@ screen=%@ bounds=%@",
        session.role, windowScene.screen, NSStringFromCGRect(windowScene.screen.bounds));

    // Main screen: load the correct storyboard for the current device idiom,
    // mirroring the old UIMainStoryboardFile / UIMainStoryboardFile~ipad keys.
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];

    NSString *storyboardName = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"iPad" : @"iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

    window.rootViewController = [storyboard instantiateInitialViewController];

    self.window = window;
    [window makeKeyAndVisible];
    Log(LOG_I, @"SCENE main window created: storyboard=%@ rootVC=%@ hidden=%d",
        storyboardName, window.rootViewController, window.hidden);
}

@end