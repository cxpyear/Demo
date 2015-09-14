//
//  MyFunc.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/9/8.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit
import Foundation



var CurrentDidChangeNotification = "CurrentDidChangeNotification"
var CurrentDidChangeName = "CurrentDidChangeName"

//var CurrentDidChangeNotification = "CurrentDidChangeNotification"
var IPDidChangeName = "IPDidChangeName"


//返回颜色
func SHColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: (red)/255.0, green: (green)/255.0, blue: (blue)/255.0, alpha: 1)

}

func getFilePath(docPath: String) -> String{
    return NSHomeDirectory().stringByAppendingPathComponent("Documents/\(docPath)")
}

