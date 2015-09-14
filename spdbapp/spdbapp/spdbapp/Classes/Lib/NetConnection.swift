//
//  NetConnection.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/9/1.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit
import Alamofire

class NetConnection: NSObject {
   
    var result: AnyObject?
    
    func httpGet(urlString: String) -> AnyObject?{
        Alamofire.request(.GET, urlString).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, data, error) -> Void in
            println("error = \(error)")
            println("data = \(data)")
            if error != nil{
                println("获取信息失败，请检测网络连接状态后重试")
                return
            }else{
                self.result = data
            }
        }
        
        return self.result
    }
  
    
    func jsonToModel(json: AnyObject){
//        GBUser.self
    }
 
}
