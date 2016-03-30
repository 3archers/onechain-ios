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
        return true
    }
}
