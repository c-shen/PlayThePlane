//
//  iAdViewController.swift
//  PlayThePlane
//
//  Created by Aiya on 15/8/27.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit
import iAd

class iAdViewController: UIViewController,ADBannerViewDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        banner.frame = view.bounds;
        self.canDisplayBannerAds = true
        banner.delegate = self
        banner.hidden = true
        view.addSubview(banner);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func bannerViewWillLoadAd(banner: ADBannerView!) {
//        NSLog("广告即将加载")
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
//        NSLog("广告加载完成")
        banner.hidden = false
    }
    /// 当点击广告左上角的叉关闭广告回到应用的时候,调用该方法
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        NSLog("bannerViewActionShouldBegin")
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        NSLog("失败!")
    }
    
    //MARK : 懒加载
    private lazy var banner : ADBannerView = ADBannerView()

}
