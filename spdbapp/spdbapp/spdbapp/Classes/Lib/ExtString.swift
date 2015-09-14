//
//  String.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation



public extension String {
    
    /**
    String length
    */
    var length: Int { return count(self) }
    
    /**
    self.capitalizedString shorthand
    */
    var capitalized: String { return capitalizedString }

    /**
    去除空格
    
    :returns: 去除空格之后的字符串
    */
    func trimAllString() -> String{
        return (self as NSString).stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    

}


  