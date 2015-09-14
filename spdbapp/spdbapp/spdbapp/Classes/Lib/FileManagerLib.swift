//
//  FileManagerLib.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/8/17.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

class FileManagerLib: NSObject {
    
    /// 判断指定路径文件是否存在
    class func isFileExist(path: String) -> Bool {
        var manager = NSFileManager.defaultManager()
        if (manager.fileExistsAtPath(path)){
            return true
        }else{
            return false
        }
    }
}
