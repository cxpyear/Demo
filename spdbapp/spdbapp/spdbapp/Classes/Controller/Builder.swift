//
//  Builder.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/5/14.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class Builder: NSObject {
    
    var current = GBMeeting()
    
    
    func loadOffLineMeeting() -> GBMeeting {
        current.sources.removeAll(keepCapacity: false)
        current.agendas.removeAll(keepCapacity: false)
        
        var localJSONPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/jsondata.txt")
        var filemanager = NSFileManager.defaultManager()

        var jsonLocal = filemanager.contentsAtPath(localJSONPath)
        var result: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonLocal!, options: NSJSONReadingOptions.AllowFragments, error: nil)!
        println("localcreatemeeting json ======local====== \(result)")
        var json = JSON(result)
        self.getMeetingInfo(json)
        
//        appManager.current = current
        return current
        
    }
    
    
    //Create Meeting offline
    func LocalCreateMeeting() -> GBMeeting {
        
        current.sources.removeAll(keepCapacity: false)
        current.agendas.removeAll(keepCapacity: false)
        
//        var localJSONPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/jsondata.txt")
//        var filemanager = NSFileManager.defaultManager()
//        
//        println("localcreatemeeting appmanaer = \(appManager.netConnect)")
//        if appManager.netConnect == true{
//            var url = NSURL(string: server.meetingServiceUrl)
//            println("localcreatemeeting url = \(url)")
//            var data = NSData(contentsOfURL: url!)
//            if(data != nil){
//                var result: AnyObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)!
//                
//                println("localcreatemeeting json ======net====== \(result)")
//                var json = JSON(result)
//                self.getMeetingInfo(json)
//            }            
//        }
//        else{
//            var jsonLocal = filemanager.contentsAtPath(localJSONPath)
//            var result: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonLocal!, options: NSJSONReadingOptions.AllowFragments, error: nil)!
//            println("localcreatemeeting json ======local====== \(result)")
//            var json = JSON(result)
//            self.getMeetingInfo(json)
//        }
//
        appManager.current = current
        return current
    }
    
    
    func getMeetingInfo(json: JSON) -> GBMeeting{
        current.id = json["id"].stringValue
        current.name = json["name"].stringValue
        
        
        println("current meetinginfo = \(current.name)")
        println("appManager.appGBUser.type = \(appManager.appGBUser.type)")
        
        if let sources = json["source"].array{
            var count = sources.count
            for var i = 0 ; i < count ; i++ {
                var source = GBSource()
                var sourceRowValue = sources[i]
                
                
                source.id = sourceRowValue["id"].stringValue
                source.name = sourceRowValue["name"].stringValue
                source.meetingtype = sourceRowValue["meetingtype"].stringValue
                source.memberrole = sourceRowValue["memberrole"].stringValue
                source.type = sourceRowValue["type"].stringValue
                source.sourextension = sourceRowValue["extension"].stringValue
                source.sourpublic = sourceRowValue["public"].stringValue
                source.link = sourceRowValue["link"].stringValue
                source.aidlink = sourceRowValue["aid-link"].stringValue
                
                var type : String?
                var role : String?
                
                
                if bNeedRefresh == true{
                    type = appManager.appGBUser.type
                    role = appManager.appGBUser.role
                }else{
                
                    var userInfoPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/UserInfo.txt")
                    var userinfo = NSMutableDictionary(contentsOfFile: userInfoPath)
                    type = userinfo?.objectForKey("type")?.string
                    role = userinfo?.objectForKey("role")?.string
                }
                println("filename = \(source.name)")
                println("appmanager.type = \(type!)===appmanager.role = \(role!)")
                println("source.meetingtype = \(source.meetingtype)===source.memberrole = \(source.memberrole)")
                
                
                //当满足人员类型等于会议类型  &&  人员角色＝＝文件分配权限／全员时，将该文件加载入对应的议程中
                var b: Bool = (source.memberrole == "全员")
                println("quanyuan info = \(b)")
                if ((type == source.meetingtype) && ((role == source.memberrole)  || (source.memberrole == "全员"))){
                    current.sources.append(source)
                }
            }
            
            for var i = 0 ; i < current.sources.count ; i++ {
                println("current.source.count\(i) = \(current.sources[i].name)")
            }
        }
        
        if let agendas = json["agenda"].array{
            var count = agendas.count
            for var  i = 0 ; i < count ; i++ {
                var agenda = GBAgenda()
                var agendaRowValue = agendas[i]
                
                agenda.id = agendaRowValue["id"].stringValue
                agenda.name = agendaRowValue["name"].stringValue
                agenda.starttime = agendaRowValue["starttime"].stringValue
                agenda.endtime = agendaRowValue["endtime"].stringValue
                agenda.reporter = agendaRowValue["reporter"].stringValue
                agenda.index = agendaRowValue["index"].stringValue
                
                if let sourceLists = agendaRowValue["source"].array{
                    var sourceCount = sourceLists.count
                    
                    for var j = 0 ; j < sourceCount ; j++ {
                        var source = GBSource()
                        var sourceId = agendaRowValue["source"][j].stringValue
                        
                        for var k = 0 ; k < current.sources.count ; k++ {
                            if current.sources[k].id == sourceId  {
                                agenda.source.append(current.sources[k])
                            }
                        }
                    }
                }
                
                current.agendas.append(agenda)
                println("current======\(current.agendas[i].source.count)")
            }
        }
        return current
    }
    
}

