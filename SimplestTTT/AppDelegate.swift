//
//  AppDelegate.swift
//  SimplestTTT
//
//  Created by verec on 28/11/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import UIKit

func scope(@noescape lambda: ()->()) {
    lambda()
}

class RIAA {
    init(appDelegate: AppDelegate, @noescape lamda:()->()) {
        /// This creates a default blank view that is fullscreen and supports
        /// all four orientations
        Top.defaultWindow.rootViewController = Top.defaultController
        Top.defaultController.view = Top.mainView
        appDelegate.window = Top.defaultWindow

        lamda()
    }

    deinit {
        Top.defaultWindow.makeKeyAndVisible()
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication
    ,   didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        scope {
            let _ = RIAA(appDelegate: self) {
                Top.mainView.backgroundColor = UIColor.redColor()
                Top.mainView.addSubview(Views.tableView)
            }
        }
        return true
    }
}

