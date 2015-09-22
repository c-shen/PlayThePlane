//
//  UIButton+Extension.swift
//  MicroBlog01
//
//  Created by Aiya on 15/8/3.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String, fontSize: CGFloat = 20, color: UIColor = UIColor.darkGrayColor(), backColor: UIColor = UIColor.whiteColor()) {
        
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setTitleColor(color, forState: UIControlState.Normal)
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    convenience init(title: String, imageName: String, fontSize: CGFloat = 12, width: CGFloat, height: CGFloat, color: UIColor = UIColor.darkGrayColor()) {
        
        self.init()
        
        setTitle(title, forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        contentEdgeInsets = UIEdgeInsetsMake(width, width, width, width)
        setTitleColor(color, forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
    
    

}
