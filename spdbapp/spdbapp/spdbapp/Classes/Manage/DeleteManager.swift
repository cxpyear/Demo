//
//  DeleteManager.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/6/2.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

class DeleteManager: NSObject {
   
    ///  删除所有的PDF文件
    class func deleteInfo(docPathExt: String){
        var filepath = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(docPathExt)")
        
        var manager = NSFileManager.defaultManager()
        
        var isTxtExist = FileManagerLib.isFileExist(filepath)
        if isTxtExist{
            var b = manager.removeItemAtPath(filepath, error: nil)
            if b {
                println("\(docPathExt)文件删除成功")
            }
        }
    }
    
    /// 删除所有的配置文件
    class func deleteAllInfo(){
        var filepath = NSHomeDirectory().stringByAppendingPathComponent("Documents")
        var manager = NSFileManager.defaultManager()
        
        if let filelist = manager.contentsOfDirectoryAtPath(filepath, error: nil){
            
            println("file = \(filelist)")
            
            var count = filelist.count
            for (var i = 0 ; i < count ; i++ ){
                var docpath = filepath.stringByAppendingPathComponent("\(filelist[i])")
                var b = manager.removeItemAtPath(docpath, error: nil)
                if b{
                    println("\(filelist[i])文件删除成功")
                }
            }
        }
    }
    
}
