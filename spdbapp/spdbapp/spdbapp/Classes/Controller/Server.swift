//
//  Server.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/6/8.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import Foundation



class Server: NSObject {
    var boxServiceUrl = String()
    var memberServiceUrl = String()
    var meetingServiceUrl = String()
    var fileServiceUrl = String()
    var heartBeatServiceUrl = String()
    var loginServiceUrl = String()
    var downloadFileUrl = String()
    
    let filePath = NSHomeDirectory().stringByAppendingPathComponent("Documents/SettingsConfig.txt")
    var url = ""
    
    override init(){
        super.init()
        
        url = getInitialIP()

        meetingServiceUrl = "http://" + url + ":18080/v1/current"
        heartBeatServiceUrl = "http://" + url + ":18080/v1/heartbeat"
        loginServiceUrl = "http://" + url + ":18080/v1/login"
        downloadFileUrl = "http://" + url + ":10086/"
        boxServiceUrl = "http://" + url + ":18080/v1/box"
        memberServiceUrl = "http://" + url + ":18080/v1/member"
        
    }
    
    func getInitialIP() -> String {
        var defaults = NSUserDefaults.standardUserDefaults()
        var value = defaults.stringForKey("txtBoxURL")
        println("url = \(value)")
        if (value?.isEmpty == nil) {
            defaults.setObject("192.168.25.33", forKey: "txtBoxURL")
            defaults.synchronize()
            return defaults.objectForKey("txtBoxURL") as! String
        }
        
        //设置界面显示本机id
        var idValue = GBNetwork.getMacId()
        defaults.setObject(idValue, forKey: "lbl_showID")
        defaults.synchronize()
        
        var versionValue = "1.0.1"
        defaults.setObject(versionValue, forKey: "lbl_Version")
        defaults.synchronize()
        
        
        defaults.synchronize()
        
        
        
        return value!
    }
    
//    func ipChange(notification: NSNotification){
//        if let userInfo = notification.userInfo{
//            var url = userInfo[IPDidChangeName] as! String
//            self.url = url
//            println("url ======== \(url)")
//        }
//    }
    

    
    
    func clearHistoryInfo(type: String){
        var filepath = NSHomeDirectory().stringByAppendingPathComponent("Documents")
        var manager = NSFileManager.defaultManager()
        if let filelist = manager.contentsOfDirectoryAtPath(filepath, error: nil){
            
            println("file = \(filelist)")
            
            var count = filelist.count
            for (var i = 0 ; i < count ; i++ ){
                if filelist[i].pathExtension == type{
                    var docpath = filepath.stringByAppendingPathComponent("\(filelist[i])")
                    var b = manager.removeItemAtPath(docpath, error: nil)
                    if b{
                        println("\(filelist[i])文件删除成功")
                    }
                }
            }
        }
    }
    
}