//
//  YJAdScrollView.swift
//  SwiftBaseProject
//
//  Created by zhangyongjie on 2017/6/30.
//  Copyright © 2017年 张永杰. All rights reserved.
//

import UIKit
import Masonry
import SDWebImage

protocol adClickDelegate {
    func openLinkUrl(linkUrl:String) -> ()
}
class ZYJADScrollView: UIScrollView ,UIScrollViewDelegate{
    let scroll_timer = 2.0
    private var pageControl:UIPageControl?
    private var currentPage:NSInteger = 0
    private var isTimeToScroll:Bool = false
    private var leftImageView:UIImageView?
    private var centerImageView:UIImageView?
    private var rightImageView:UIImageView?
    private var dataModel:NSArray?
    private var timer:Timer?
    var adDelegate:adClickDelegate?
    init(frame: CGRect,dataModel:NSArray,adDelegate:adClickDelegate) {
        super.init(frame: frame)
        self.delegate = self
        self.dataModel = dataModel
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.adDelegate = adDelegate
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(ZYJADScrollView.jumpToWebView))
        self.addGestureRecognizer(tap)
        self.addADContentImage()
        if self.dataModel?.count == 1 {
            self.contentSize = CGSize.init(width: self.width() * CGFloat.init((self.dataModel?.count)!), height: frame.size.height)
        }else{
            self.contentSize = CGSize.init(width: self.width() * CGFloat.init(3), height: frame.size.height)
            self.contentOffset = CGPoint.init(x: self.width(), y: 0)
            self.startTimerToScroll()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createPageControllOnView(superView:UIView) -> () {
        pageControl = UIPageControl.init()
        pageControl?.pageIndicatorTintColor = UIColor.white
        pageControl?.currentPageIndicatorTintColor = UIColor.gray
        pageControl?.numberOfPages = (self.dataModel?.count)!
        pageControl?.currentPage = 0
        pageControl?.isEnabled = false
        superView.addSubview(pageControl!)
        superView.bringSubview(toFront: pageControl!)
        _ = pageControl?.mas_makeConstraints({ (make:MASConstraintMaker?) in
            _ = make?.centerX.equalTo()(superView.mas_centerX)
            _ = make?.width.mas_equalTo()(20 * CGFloat.init((self.dataModel?.count)!))
            _ = make?.height.mas_equalTo()(20)
            _ = make?.bottom.equalTo()(superView.mas_bottom)?.setOffset(0)
        })
    }
    
    func jumpToWebView() -> () {
        if self.adDelegate != nil {
//            let detailModel = self.dataModel?.data.list.object(at: currentPage) as! HomeBannerDetailModel
            self.adDelegate?.openLinkUrl(linkUrl: "")
        }
    }
    
    func addADContentImage() -> () {
        currentPage = 0
        if self.dataModel?.count == 1 {
            leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.width(), height: self.height()))
            self.addSubview(leftImageView!)
        }else if(self.dataModel?.count == 2){
            leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.width(), height: self.height()))
            centerImageView = UIImageView.init(frame: CGRect.init(x: self.width(), y: 0, width: self.width(), height: self.height()))
            rightImageView = UIImageView.init(frame: CGRect.init(x: self.width() * 2, y: 0, width: self.width(), height: self.height()))
            self.addSubview(leftImageView!)
            self.addSubview(centerImageView!)
            self.addSubview(rightImageView!)
        }else{
            leftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.width(), height: self.height()))
            centerImageView = UIImageView.init(frame: CGRect.init(x: self.width(), y: 0, width: self.width(), height: self.height()))
            rightImageView = UIImageView.init(frame: CGRect.init(x: self.width() * 2, y: 0, width: self.width(), height: self.height()))
            self.addSubview(leftImageView!)
            self.addSubview(centerImageView!)
            self.addSubview(rightImageView!)
        }
        self.setImages()
    }
    
    func setImages() -> () {
        if self.dataModel?.count == 1 {
            let detailModel = self.dataModel?.object(at: 0) as! String
            leftImageView?.sd_setImage(with: NSURL.init(string: detailModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
        }else if(self.dataModel?.count == 2){
            let leftModel = self.dataModel?.object(at: self.previousPage()) as! String
            leftImageView?.sd_setImage(with: NSURL.init(string: leftModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
            
            let centerModel = self.dataModel?.object(at: self.currentPage) as! String
            centerImageView?.sd_setImage(with: NSURL.init(string: centerModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
            
            let rightModel = self.dataModel?.object(at: self.nextPage()) as! String
            rightImageView?.sd_setImage(with: NSURL.init(string: rightModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
        }else{
            let leftModel = self.dataModel?.object(at: self.previousPage()) as! String
            leftImageView?.sd_setImage(with: NSURL.init(string: leftModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
            
            let centerModel = self.dataModel?.object(at: self.currentPage) as! String
            centerImageView?.sd_setImage(with: NSURL.init(string: centerModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
            
            let rightModel = self.dataModel?.object(at: self.nextPage()) as! String
            rightImageView?.sd_setImage(with: NSURL.init(string: rightModel) as URL?, placeholderImage: UIImage.init(named: "null_data_banner"))
        }
    }
    
    func previousPage() -> NSInteger {
        if currentPage == 0 {
            return (self.dataModel?.count)! - 1
        }else{
            return currentPage - 1
        }
    }
    
    func nextPage() -> NSInteger {
        if currentPage == (self.dataModel?.count)! - 1 {
            return 0
        }else{
            return currentPage + 1
        }
    }
    
    func startTimerToScroll() -> () {
        timer = Timer.scheduledTimer(timeInterval: scroll_timer, target: self, selector: #selector(ZYJADScrollView.startScroll), userInfo: nil, repeats: true)
    }
    
    func startScroll() -> () {
        self.setContentOffset(CGPoint.init(x: self.width() * CGFloat.init(2), y: 0), animated: true)
        isTimeToScroll = true
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ZYJADScrollView.scrollViewDidEndDecelerating(_:)), userInfo: nil, repeats: false)
    }
    
    //dealloc
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.contentOffset.x == 0 {
            currentPage = self.previousPage()
            self.setImages()
        }else if (self.contentOffset.x == self.width() * CGFloat.init(2)){
            currentPage = self.nextPage()
            self.setImages()
        }else{
            return
        }
        pageControl?.currentPage = currentPage
        self.contentOffset = CGPoint.init(x: self.width(), y: 0)
        if isTimeToScroll == false {
            timer?.fireDate = NSDate.init(timeIntervalSinceNow: Double(scroll_timer)) as Date
        }
        isTimeToScroll = false
    }
    
}

