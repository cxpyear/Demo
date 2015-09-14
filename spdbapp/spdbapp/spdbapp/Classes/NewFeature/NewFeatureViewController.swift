//
//  NewFeatureViewController.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/9/9.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

var numsOfPic = 4

class NewFeatureViewController: UIViewController, UIScrollViewDelegate {

    
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        var scrollH = self.view.bounds.height
        var scrollW =  self.view.bounds.width
        
        for var i = 0 ; i < numsOfPic ; i++ {
            var imageView = UIImageView()
            var x = CGFloat(i) * scrollW
            imageView.frame = CGRectMake(x, 0, scrollW, scrollH)
            var imageName = "new_feature_\(i + 1)"
//            println("imagename = \(imageName)")
            imageView.image = UIImage(named: imageName)
            scrollView.addSubview(imageView)
            
            if i == (numsOfPic - 1){
                self.setLastImage(imageView)
            }
        }
        
        scrollView.contentSize = CGSize(width: scrollW * CGFloat(numsOfPic), height: CGFloat(0))
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        
        
        pageControl.numberOfPages = numsOfPic
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.center.x = self.view.center.x
        pageControl.center.y = scrollH - 40
        self.view.addSubview(pageControl)

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page = Double(scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = Int(page + 0.5)
    }
    
    /**
    在最后一张展示新特性图片上增加计入系统按钮
    
    :param: imageView 最后一张图片
    */
    func setLastImage(imageView: UIImageView){
        var startBtn = UIButton()
        startBtn.frame = CGRectMake(self.view.center.x, self.view.frame.height * 0.8, 160 , 65)
        startBtn.layer.cornerRadius = 8
        startBtn.setTitle("进入系统", forState: UIControlState.Normal)
        startBtn.backgroundColor = SHColor(143, 1, 43)
        startBtn.addTarget(self, action: "startClick", forControlEvents: UIControlEvents.TouchUpInside)
        imageView.userInteractionEnabled = true
        imageView.addSubview(startBtn)
    }
    
    func startClick(){
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var registerVC = storyBoard.instantiateViewControllerWithIdentifier("view") as! RegisViewController
        self.presentViewController(registerVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
