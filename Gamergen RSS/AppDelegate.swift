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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }

    // Point d'entrée de l'application de l'activation en background fetch permettant de mettre à jour le badge de l'application
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        var defaults: UserDefaults = UserDefaults.standard
       
        var category : GGCategory?
        
        // on récupère la catégorie a comptabiliser
        if let savedCategory = defaults.object(forKey: "category") as? String {
            category = GGCategories.getCategoryByTag(savedCategory)
        } else {
            category = GGCategories.getCategoryByName("Global")
        }
        
        var downloader = Downloader(categorie: category!)
        downloader.download({ (feed, error) -> Void in
            if error == nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    var badgeCount = 0
                    
                    // on compte le nombre d'article jusqu'au dernier lu (max 20 à priori)
                    if let lastArticleReadUrl = UserDefaults.standard.object(forKey: "lastArticleRead") as? String {
                        for article in feed!.feed {
                            if article.link.absoluteString == lastArticleReadUrl {
                                break
                            } else {
                                badgeCount++
                            }
                        }
                    }
                    
                    // on met à jour le badge de l'application
                    UIApplication.shared.applicationIconBadgeNumber = badgeCount
                    completionHandler(UIBackgroundFetchResult.newData)
                })
                
            } else {
                completionHandler(UIBackgroundFetchResult.failed)
            }
        })
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

