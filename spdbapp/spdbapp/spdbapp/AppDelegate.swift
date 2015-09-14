//
//  AppDelegate.swift
//  spdbapp
//
//  Created by tommy on 15/5/7.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

//var server = Server()
//var builder = Builder()
var appManager = AppManager()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        var key = "CFBundleVersion"
//        //获取当前运行版本号
//        var currentVersion = NSBundle.mainBundle().objectForInfoDictionaryKey(key) as! NSString
////        println("currentVersion = \(currentVersion)")
//        
//        //获取之前存储在系统中的版本号
//        var lastVersion: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(key)
        
//        println("lastVersion = \(lastVersion)")
        
        
//        var idKey = "CurrentDeviceId"
//        var currentDeviceId: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(idKey)
//        //如果当前id为空
//        if currentDeviceId == nil {
//
////            appManager.createBox()
//            
//            
//            var storyBorad = UIStoryboard(name: "Main", bundle: nil)
//            var registerVC = storyBorad.instantiateViewControllerWithIdentifier("view") as! RegisViewController
////            registerVC.bNeedPostNote = true
//            self.window?.rootViewController = registerVC
//        }
        
        
        // 判断如果当前版本号＝＝之前存储版本好，直接跳转到登录界面，否则跳转到展示新特性界面
//        if (currentVersion.isEqual(lastVersion)){
//            var storyBorad = UIStoryboard(name: "Main", bundle: nil)
//            var registerVC = storyBorad.instantiateViewControllerWithIdentifier("view") as! RegisViewController
//            self.window?.rootViewController = registerVC
//        }else{
//            var newFeatureVC = NewFeatureViewController()
//            self.window?.rootViewController = newFeatureVC
//            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: key)
//            NSUserDefaults().synchronize()
//        }
        
//        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
//        println("applicationWillResignActive")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        println("applicationDidEnterBackground")
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "defaultsSettingsChanged", name: NSUserDefaultsDidChangeNotification, object: nil)
        
             }

    func applicationWillEnterForeground(application: UIApplication) {
//        var defaults = NSUserDefaults.standardUserDefaults()
//        defaults.synchronize()
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
         
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
   


}

