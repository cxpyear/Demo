//
//  DocViewController.swift
//  spdbapp
//
//  Created by tommy on 15/5/8.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit
import Alamofire

class DocViewController: UIViewController,UIWebViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var btnLeftBottom: UIButton!
    @IBOutlet weak var btnRightBottom: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var txtShowTotalPage: UITextField!
    @IBOutlet weak var txtShowCurrentPape: UITextField!
    @IBOutlet weak var btnPrevious: UIButton!
 
    @IBOutlet weak var btnAfter: UIButton!
    
    var isScreenLocked: Bool = false

    
    var fileIDInfo: String?
    var fileNameInfo: String?
    
    var timer = Poller()

    var topBarView = TopbarView()
    var bottomBarView = BottomBarView()

    var totalPage = 0
    var currentPage = 0
    var docPath = String()
    
    @IBOutlet weak var docView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        docPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(fileIDInfo!).pdf")
        loadLocalPDFFile()
        totalPage = initfile()
        
        topBarView = TopbarView.getTopBarView(self)
        topBarView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(topBarView)
        
        bottomBarView = BottomBarView().getBottomInstance(self)
        self.view.addSubview(bottomBarView)
        bottomBarView.returnBtnBack(self, action: "back")

        
        txtShowCurrentPape.delegate = self
        txtShowTotalPage.text = "共\(totalPage)页"
        self.currentPage = 1
        
        self.docView.scrollView.delegate = self
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "hideOrShowBottomBar:")
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
//        docPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(fileIDInfo!).pdf")
    }
    
    func hideOrShowBottomBar(gesture: UITapGestureRecognizer){
        self.bottomBarView.hidden = !self.bottomBarView.hidden
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.txtShowCurrentPape{
            self.txtShowCurrentPape.endEditing(true)
        }
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        if textField == self.txtShowCurrentPape{
            if textField.text.isEmpty{
                return
            }
            
            var value = self.txtShowCurrentPape.text
            var temp = String(value)
            var page = temp.toInt()!
            if page <= 0{
                return
            }
            skipToPage(page)
            currentPage = page
           
        }
    }
    
    /**
    跳转到pdf指定的页码
    
    :param: num 指定的pdf跳转页码位置
    */
    func skipToPage(num: Int){
//        var strPath = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(fileIDInfo!).pdf")
        var totalPages = self.initfile()
        
        var totalPDFheight = docView.scrollView.contentSize.height
        
        var horizontalPaddingBetweenPages = 10 * (totalPages + 1)
        var temp = totalPDFheight - CGFloat(horizontalPaddingBetweenPages)
        var pageHeight = CGFloat(temp / CGFloat(totalPages))
        
        var specificPageNo = num
        if specificPageNo <= totalPages{
            
            var p = specificPageNo - 1
            var value1 = CGFloat(10 * p)
            var value2 = CGFloat( pageHeight * CGFloat(p) )
            var sb: CGFloat = CGFloat(value1 + value2)
            var offsetPage = CGPointMake(0, sb)
            docView.scrollView.setContentOffset(offsetPage, animated: true)
        }
        println("currentpage = \(currentPage)")
    }
    
    
    /**
    跳转到pdf文档第一页
    */
    @IBAction func btnToFirstPageClick(sender: UIButton) {
        skipToPage(1)
        currentPage = 1
        self.txtShowCurrentPape.text = String(currentPage)
    }
    
    /**
    跳转到pdf文档最后一页
    */
    @IBAction func btnToLastPageClick(sender: UIButton) {
        skipToPage(totalPage)
        currentPage = totalPage
        self.txtShowCurrentPape.text = String(currentPage)
    }
    
    /**
    跳转到pdf文档下一页
    */
    @IBAction func btnToNextPageClick(sender: UIButton) {
        if currentPage < totalPage  {
            ++currentPage
            skipToPage(currentPage)
            self.txtShowCurrentPape.text = String(currentPage)
            
        }
    }

    
    /**
    跳转到pdf文档上一页
    */
    @IBAction func btnToPreviousPageClick(sender: UIButton) {
        if currentPage > 1 {
            --currentPage
            skipToPage(currentPage)
            
            self.txtShowCurrentPape.text = String(currentPage)
        }
        println("==============1")
    }
    
    
    func autoHideBottomBarView(timer: NSTimer){
        if self.bottomBarView.hidden == false{
            self.bottomBarView.hidden = true
        }
    }
    
    
    
    
    /**
    返回当前pdf文件的总页数
    
    :returns: 当前pdf文档总页数
    */
    func initfile() -> Int {
//        var dataPathFromApp = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(fileIDInfo!).pdf")
        var path: CFString = CFStringCreateWithCString(nil, docPath, CFStringEncoding(CFStringBuiltInEncodings.UTF8.rawValue))
        var url: CFURLRef = CFURLCreateWithFileSystemPath(nil , path, CFURLPathStyle.CFURLPOSIXPathStyle, 0)
        var document: CGPDFDocumentRef = CGPDFDocumentCreateWithURL(url)
        var totalPages = CGPDFDocumentGetNumberOfPages(document)
        return totalPages
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
//        var totalPages = self.initfile()
//        
//        var totalPDFheight = docView.scrollView.contentSize.height
//        
//        var horizontalPaddingBetweenPages = 10 * (totalPages + 1)
//        var temp = totalPDFheight - CGFloat(horizontalPaddingBetweenPages)
//        var pageHeight = CGFloat(temp / CGFloat(totalPages))
        
        
//        var page = (scrollView.contentOffset.y - 20 ) / pageHeight
//        println("page========\(scrollView.contentOffset.y)")
//        var p = Int(page)
        
        
        println("offset.y = \((scrollView.contentOffset.y ))")
        
        var page = (scrollView.contentOffset.y ) / (self.view.frame.height)
        var p = Int(page + 0.5)
        self.txtShowCurrentPape.text = "\(p + 1)"
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //加锁
    @IBAction func addLock(sender: UIButton) {
        self.isScreenLocked = !self.isScreenLocked
        
        var imageName = (self.isScreenLocked == true) ? "Lock-50" : "Unlock-50"
        sender.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        topBarView.lblIsLocked.text = (self.isScreenLocked == true) ? "当前屏幕已锁定" : ""
    }
    
    override func shouldAutorotate() -> Bool {
        return !self.isScreenLocked
    }
    
    
    /**
    加载当前pdf文档
    */
    func loadLocalPDFFile(){
//        var filePath: String = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(self.fileIDInfo!).pdf")
        var urlString = NSURL(fileURLWithPath: "\(docPath)")
        var request = NSURLRequest(URL: urlString!)
        self.docView.loadRequest(request)
//        println("path = \(filePath)")
        skipToPage(1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
