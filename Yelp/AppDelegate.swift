//
//  AppDelegate.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = UIColor(red:0.8, green:0.15, blue:0.09, alpha:1)
        //        navigationBarAppearace.titleTextAttributes = [NSFontAttributeName: UIFont(name: "MarketingScript", size: 30)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
                
        // set up some saved defaults
        if let config = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("config", ofType: "plist")!) {
            let ConsumerKey = config.objectForKey("CONSUMER_KEY") as String
            let ConsumerSecret = config.objectForKey("CONSUMER_SECRET") as String
            let Token = config.objectForKey("TOKEN") as String
            let TokenSecret = config.objectForKey("TOKEN_SECRET") as String

            let defaultSettings = ["ConsumerKey": ConsumerKey,
                                   "ConsumerSecret": ConsumerSecret,
                                   "Token": Token,
                                   "TokenSecret": TokenSecret]
            NSUserDefaults.standardUserDefaults().registerDefaults(defaultSettings)
        }
        else {
            // API KEY ERROR
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

