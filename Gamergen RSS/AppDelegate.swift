//
//  AppDelegate.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }

    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
       
        var category : GGCategory?
        
        // on récupère la catégorie a comptabiliser
        if let savedCategory = defaults.objectForKey("category") as? String {
            category = GGCategories.getCategoryByTag(savedCategory)
        } else {
            category = GGCategories.getCategoryByName("Global")
        }
        
        var downloader = Downloader(categorie: category!)
        downloader.download({ (feed, error) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    var badgeCount = 0
                    
                    // on compte le nombre d'article jusqu'au dernier lu (max 20 à priori)
                    if let lastArticleReadUrl = NSUserDefaults.standardUserDefaults().objectForKey("lastArticleRead") as? String {
                        for article in feed!.feed {
                            if article.link.absoluteString == lastArticleReadUrl {
                                break
                            } else {
                                badgeCount++
                            }
                        }
                    }
                    
                    // on met à jour le badge de l'application
                    UIApplication.sharedApplication().applicationIconBadgeNumber = badgeCount
                    completionHandler(UIBackgroundFetchResult.NewData)
                })
                
            } else {
                completionHandler(UIBackgroundFetchResult.Failed)
            }
        })
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

