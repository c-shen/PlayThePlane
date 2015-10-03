//
//  helpViewController.swift
//  PlayThePlane
//
//  Created by Aiya on 15/10/1.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit

class helpViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helpWebView.userInteractionEnabled = false
        helpScrollView.bounces = false
        
        helpScrollView.frame = CGRect(x: 0, y: 40, width: view.bounds.width, height: view.bounds.height-40)
        backoutBtn.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 40)
        helpWebView.frame = helpScrollView.bounds
        
        helpWebView.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        
        let url = NSURL(string: "https://github.com/c-shen/PlayThePlane/blob/master/README.md")
        let request = NSURLRequest(URL: url!)
        helpWebView.loadRequest(request)
        view.addSubview(helpScrollView)
        helpScrollView.addSubview(helpWebView)
        view.addSubview(backoutBtn)
        backoutBtn.addTarget(self, action: "backout", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let change = change {
            
            let webSize = change[NSKeyValueChangeNewKey]?.CGSizeValue()
            
            helpWebView.frame.size = webSize!
            helpScrollView.contentSize = webSize!
        }
        
    }
    
    @objc func backout() {
        helpWebView.scrollView.removeObserver(self, forKeyPath: "contentSize")
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 懒加载控件
    private lazy var helpWebView: UIWebView = UIWebView()
    private lazy var helpScrollView: UIScrollView = UIScrollView()
    private lazy var backoutBtn: UIButton = UIButton(title: "返回游戏", fontSize: 20, color: UIColor.blackColor(), backColor: UIColor.grayColor())
    
}
