//
//  AppDelegate.swift
//  OneChain
//
//  Created by Xiaofei Long on 3/25/16.
//  Copyright © 2016 3archers. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
    ) -> Bool {
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (config: ParseMutableClientConfiguration) -> Void in
                config.applicationId = "OneChain"
                config.clientKey = "mZASPf2L6NINoCsEdprsl2GN1gO6kDbi"
                config.server = "https://onechain.herokuapp.com/parse"
            })
        )

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "userDidSignOut",
            name: userDidSignOutNotification,
            object: nil
        )

        if PFUser.currentUser() != nil {
            window?.rootViewController =
                storyboard.instantiateViewControllerWithIdentifier("Home Navigation Controller")
                as! UINavigationController
        }
        return true
    }

    func userDidSignOut() {
        window?.rootViewController = storyboard.instantiateInitialViewController()
    }
}
