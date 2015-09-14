//
//  BottomBarView.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/7/27.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

class BottomBarView: UIView {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnReconnect: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.hidden = true
        self.btnReconnect.addTarget(self, action: "getReconn", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.lblUserName.text = appManager.appGBUser.name
        
        Poller().start(self, method: "checkstatus:", timerInter: 5.0)
        
        if appManager.netConnect == true {
            self.btnReconnect.hidden = true
        }
        
       
        
    }
 
    
    func checkstatus(timer: NSTimer){
        self.btnReconnect.hidden = (appManager.netConnect == true) ? true : false
    }
    
    //页面下方的“重连”按钮出发的事件
    func getReconn(){
        appManager.starttimer()
    }
    
//    func getName() {
//        var filePath = NSHomeDirectory().stringByAppendingPathComponent("Documents/UserInfo.txt")
//        println("file path＝\(filePath)")
//        var readData = NSData(contentsOfFile: filePath)
//        var name = NSString(data: readData!, encoding: NSUTF8StringEncoding)! as NSString
//        
//        if (name.length > 0){
//            self.lblUserName.text = name as String
//        }
//    }
    func getBottomInstance(owner: NSObject) -> BottomBarView {
        
        var view = NSBundle.mainBundle().loadNibNamed("BottomBarView", owner: owner, options: nil)[0] as! BottomBarView
        var p = owner as! UIViewController
        view.frame = CGRectMake(0, p.view.frame.height - 49, p.view.frame.width, 49)
        
//        var tapGesture = UITapGestureRecognizer(target: owner, action: "hideOrShowBottomBar:")
//        tapGesture.cancelsTouchesInView = false
//        p.view.addGestureRecognizer(tapGesture)
        
        return view
    }
    
//    class func getBottomInstance(owner: NSObject) -> BottomBarView {
//    
//        var view = NSBundle.mainBundle().loadNibNamed("BottomBarView", owner: owner, options: nil)[0] as! BottomBarView
//        var p = owner as! UIViewController
//        view.frame = CGRectMake(0, p.view.frame.height - 49, p.view.frame.width, 49)
//        
//        var tapGesture = UITapGestureRecognizer(target: owner, action: "hideOrShowBottomBar:")
//        tapGesture.cancelsTouchesInView = false
//        p.view.addGestureRecognizer(tapGesture)
//        
//        Poller().start(owner, method: "autoHideBottomBarView:", timerInter: 5.0)
//        
//        
//        return view
//    }
    
//    func autoHideBottomBarView(timer: NSTimer){
//        if self.bottomBarView.hidden == false{
//            self.bottomBarView.hidden = true
//        }
//    }
    
    func hideOrShowBottomBar(gesture: UITapGestureRecognizer){
        self.hidden = !self.hidden
    }
    
    func returnBtnBack(target: AnyObject, action: Selector) -> UIButton{
        btnBack.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return btnBack
    }
    
    
}
