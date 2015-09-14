//
//  Models.swift
//  spdbapp
//
//  Created by tommy on 15/5/11.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import Foundation

protocol GBModelBaseAciton {
    func Add()
    func Update()
    func Del()
    func Find()
}

//meeting type
enum GBMeetingType {
    case HANGBAN, DANGBAN, DANGWEI, DONGSHI, ALL
}


class GBBase: NSObject {
    var basename = ""
}

class GBUser: NSObject {
    var username = String()
    var name = String()
    var password = String()
    var type = String()
    var role = String()
    
//    required init(coder aDecoder: NSCoder) {
//        username = aDecoder.decodeObjectForKey(username) as! String
//        name = aDecoder.decodeObjectForKey(name) as! String
//        type = aDecoder.decodeObjectForKey(type) as! String
//        role = aDecoder.decodeObjectForKey(role) as! String
//        password = aDecoder.decodeObjectForKey(password) as! String
//        
//    }
//    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(username, forKey: username)
//        aCoder.encodeObject(name, forKey: name)
//        aCoder.encodeObject(password, forKey: password)
//        aCoder.encodeObject(type, forKey: type)
//        aCoder.encodeObject(role, forKey: role)
//    }
}

class GBServer:NSObject{
    var id = String()
    var name = String()
    var chairname = String()
    var service = String()
    var createtime = String()
}


class GBBox: GBBase {
    var macId : String = "11-22-33-44-55-66"
//    var type : GBMeetingType?
    var type : String = ""
    var name: String = ""

    
    var connect: Bool = false
    
    override init(){
        super.init()
        type = ""
            //GBMeetingType.ALL
        macId = GBNetwork.getMacId()
        name = ""

        connect = false
    }
}


class GBMeeting: GBBase {
    var name: String = ""
//    var type : GBMeetingType = .ALL
    var startTime: NSDate = NSDate()
    var status: Bool?
    var id: String = ""
    var agendas = [GBAgenda]()
    var sources = [GBSource]()
}

class GBSource : NSObject {
    var id: String
    var type: String
    var name: String
    var sourextension: String
    var sourpublic: String
    var link: String
    var aidlink: String
//    var local: String
    var meetingtype: String
    var memberrole: String

    override init(){
        id = ""
        type = ""
        name = ""
        sourextension = ""
        sourpublic = ""
        link = ""
        aidlink = ""
//        local = ""
        meetingtype = ""
        memberrole = ""
    }

    
}


class GBAgenda: NSObject {
    var id: String = ""
    var name: String = ""
    var source: [GBSource] = []
    var index: String = ""
    var starttime: String = ""
    var endtime: String = ""
    var reporter: String = ""
//    var sourceList = [GBSource]()
    
    //新增source
    
}


//class GBDoc: GBBase {
//    var id: String = ""
//    var index: Int = 0
//    var count: Int = 0
//    var type: GBMeetingType = .ALL
//    var status: Bool?
//    var pdfPath: String = ""
//    var size: Int = 0
//    var createAt: String = ""
//    var path: String = ""
//    var name: String = ""
//}

