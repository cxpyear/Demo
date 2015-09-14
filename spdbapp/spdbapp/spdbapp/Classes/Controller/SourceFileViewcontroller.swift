//
//  SourceFileViewcontroller.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/7/7.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit
import Alamofire

class SourceFileViewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {

    @IBOutlet weak var sourceTableview: UITableView!
    @IBOutlet weak var lblShowMeetingName: UILabel!
    @IBOutlet weak var lblShowAgendaName: UILabel!
    
    var agendaNameInfo = String()
    var agendaIndex = 0

//    var gbSource = GBSource()
//    var gbAgenda = GBAgenda()
//    var gbSourceName = [String]()
    
    var gbSourceInfo = [GBSource]()
    
    var sourceNameInfo = String()
    var sourceIdInfo = String()
    
    
    var bottomBarView = BottomBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblShowAgendaName.text = self.agendaNameInfo
        self.view.addSubview(TopbarView.getTopBarView(self))
        
        bottomBarView = BottomBarView().getBottomInstance(self)
        self.view.addSubview(bottomBarView)
        bottomBarView.returnBtnBack(self, action: "back")

        sourceTableview.tableFooterView = UIView(frame: CGRectZero)
        var cell = UINib(nibName: "SourceTableViewCell", bundle: nil)
        sourceTableview.registerNib(cell, forCellReuseIdentifier: "cell")
        
        self.gbSourceInfo = appManager.current.agendas[agendaIndex].source
        
        
        self.lblShowMeetingName.text = appManager.current.name

        Poller().start(self, method: "autoHideBottomBarView:", timerInter: 5.0)
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "hideOrShowBottomBar:")
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        if bNeedRefresh == true{
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "getCurrentChange:", name: CurrentDidChangeNotification, object: nil)
        }else{
            self.gbSourceInfo = appManager.current.agendas[agendaIndex].source
            self.lblShowMeetingName.text = appManager.current.name
            self.sourceTableview.reloadData()
        }
    }
    
    func getCurrentChange(notification: NSNotification){
        self.gbSourceInfo = appManager.current.agendas[agendaIndex].source
        self.lblShowMeetingName.text = appManager.current.name
        self.sourceTableview.reloadData()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if bNeedRefresh == true{
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    func hideOrShowBottomBar(gesture: UITapGestureRecognizer){
        self.bottomBarView.hidden = !self.bottomBarView.hidden
    }
    
    func autoHideBottomBarView(timer: NSTimer){
        if self.bottomBarView.hidden == false{
            self.bottomBarView.hidden = true
        }
    }

    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
    隐藏顶部菜单栏
    
    :returns: true表示隐藏顶部菜单栏
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gbSourceInfo.count
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SourceTableViewCell
        
        var sourceFile = self.gbSourceInfo[indexPath.row]
        cell.lblShowSourceFileName.text = sourceFile.name.stringByDeletingPathExtension
//        println("downloadlist.count = \(downloadlist.count)")
        
        if DownLoadManager.isFileDownload(sourceFile.id){
            cell.downloadProgressBar.hidden = true;
            cell.lblShowDownloadPercent.hidden = true
            cell.imgShowFileStatue.image = UIImage(named: "File-50")
        }
        
        for var i = 0; i < downloadlist.count  ; i++ {
            if sourceFile.id == downloadlist[i].fileid {
                if !DownLoadManager.isSamePDFFile(sourceFile.id){
                    cell.lblShowDownloadPercent.text = "\(Int(Float(downloadlist[i].filebar) * 100))%"
                    cell.downloadProgressBar.progress = Float(downloadlist[i].filebar)

                }
            }
        }
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        var name = self.gbSourceInfo[indexPath.row].name
        var id = self.gbSourceInfo[indexPath.row].id
//        println("segue name==================\(name)")
        self.sourceNameInfo = name
        self.sourceIdInfo = id
        
        var isFileExist = DownLoadManager.isFileDownload(self.sourceIdInfo)
        if isFileExist == false {
            UIAlertView(title: "提醒", message: "文件还在下载，请稍候打开", delegate: self, cancelButtonTitle: "确定").show()

        }else{
            self.performSegueWithIdentifier("sourceToDoc", sender: self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sourceToDoc"{
            var obj = segue.destinationViewController as! DocViewController
            obj.fileNameInfo = self.sourceNameInfo
            obj.fileIDInfo = self.sourceIdInfo
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}