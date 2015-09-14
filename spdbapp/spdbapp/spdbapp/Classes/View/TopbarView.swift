//
//  TopbarView.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/7/22.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit
import Foundation

class TopbarView: UIView {

    @IBOutlet weak var imgShowWifi: UIImageView!
    @IBOutlet weak var imgShowConnectState: UIImageView!
    @IBOutlet weak var lblShowCurrentTime: UILabel!
    @IBOutlet weak var lblIsLocked: UILabel!
    @IBOutlet weak var lblShowBattery: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clearColor()
        
        if appManager.netConnect == true {
            self.imgShowConnectState.image = UIImage(named: "Link-50")
            self.imgShowWifi.image = UIImage(named: "WiFi-50")
        }
        
        getCurrentTime()
        self.lblShowBattery.text = "\(UIDevice.currentDevice().batteryLevel * 100)%"
    
        //每隔1s刷新显示顶部菜单的时间
        Poller().start(self, method: "getCurrentTime", timerInter: 1.0)
        Poller().start(self, method: "checkTopBarStatus:",timerInter: 5.0)
        
        Poller().start(self, method: "getCurrentBattery", timerInter: 5.0)
        
    }
    
    
    /**
    定时轮询当前wifi和服务器连接状态，并根据状态刷新顶部的菜单
    
    :param: timer 定时器轮询间隔
    */
    func checkTopBarStatus(timer: NSTimer){
        self.imgShowConnectState.image = (appManager.netConnect == true) ? UIImage(named: "Link-50") : UIImage(named: "Broken Link-50")
        self.imgShowWifi.image = (appManager.wifiConnect == true) ? UIImage(named: "WiFi-50") : UIImage(named: "WiFi-50_err")
    }
    
    
    func getCurrentBattery(){
        self.lblShowBattery.text = "\(UIDevice.currentDevice().batteryLevel * 100)%"
    }
    

    /**
    获取系统当前时间
    */
    func getCurrentTime(){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        self.lblShowCurrentTime.text = formatter.stringFromDate(NSDate())
    }
    
    

    class func getTopBarView(owner: NSObject) -> TopbarView {
        var p = owner as! UIViewController
        var result = NSBundle.mainBundle().loadNibNamed("TopbarView", owner: owner, options: nil)[0] as! TopbarView
        result.frame = CGRectMake(0, 0, p.view.frame.width, 15)
        
        return result
    }
}
