//
//  ViewController.swift
//  Play the plane
//
//  Created by Aiya on 15/8/20.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UMSocialUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.contents = UIImage(named: "icon_1")!.CGImage
        setupUI()
    }
    
    
    @objc func solitaireGame() {
        
        let main = MainController()
        
        presentViewController(main, animated: true) { () -> Void in
            main.pattern = 1
        }
    }
    
    
    @objc func shareGame() {
        
        UMSocialConfig.setSupportedInterfaceOrientations(UIInterfaceOrientationMask.Landscape)
        
        UMSocialSnsService.presentSnsIconSheetView(self, appKey:"55e5338f67e58e51ae0010da", shareText: "很好玩的小游戏,小时都玩过吧!https://github.com/c-shen", shareImage: UIImage(named: "icon.png"), shareToSnsNames: [UMShareToSina, UMShareToWechatTimeline, UMShareToWechatSession, UMShareToTencent,UMShareToRenren, UMShareToDouban, UMShareToLine, UMShareToQQ], delegate: self)
        
    }
    
    @objc func localAreaGame() {
        
        let main = MainController()
        
        presentViewController(main, animated: true) { () -> Void in
            main.pattern = 2
        }
    }
    
    private let MyiAd: iAdViewController = iAdViewController()
    
    private func setupUI() {
        // 1. 添加控件
        view.addSubview(solitaire)
        view.addSubview(share)
        //        view.addSubview(localArea)
        
        solitaire.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: solitaire, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: solitaire, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
        share.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: share, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: solitaire, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: share, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: solitaire, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40))
        //        localArea.translatesAutoresizingMaskIntoConstraints = false
        //        view.addConstraint(NSLayoutConstraint(item: localArea, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: share, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
        //        view.addConstraint(NSLayoutConstraint(item: localArea, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: share, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 40))
        
        solitaire.addTarget(self, action: "solitaireGame", forControlEvents: UIControlEvents.TouchUpInside)
        share.addTarget(self, action: "shareGame", forControlEvents: UIControlEvents.TouchUpInside)
        //        localArea.addTarget(self, action: "localAreaGame", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 懒加载控件
    private lazy var solitaire: UIButton = UIButton(title: "单人游戏", imageName: "btn", fontSize: 20, width: 5 , height: 5, color: UIColor.whiteColor())
    
    private lazy var share: UIButton = UIButton(title: "分享游戏", imageName: "btn", fontSize: 20, width: 5 , height: 5, color: UIColor.whiteColor())
    
    //    private lazy var localArea: UIButton = UIButton(title: "局域对战", imageName: "btn", fontSize: 20, width: 5 , height: 5, color: UIColor.whiteColor())
}

