//
//  MyPlaneView.swift
//  Play the plane
//
//  Created by Aiya on 15/8/22.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit


protocol MyPlaneCollectionViewControlerDelegate: NSObjectProtocol {
    
    func result(standard: Bool)
    
}

private let reuseIdentifier = "Cell"

class MyPlaneCollectionViewControler: UICollectionViewController {
    
    weak var myPlaneDelegate: MyPlaneCollectionViewControlerDelegate?
    
    var attackCount = Int()
    var myHearArray = [NSIndexPath]()
    var myPlane = [NSIndexPath]()
    private let imageIcon = UIImage(named: "background3")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCollectionView()
        
    }
    
    
    func addMyPlane(firstPlane: [NSIndexPath], secondPlane: [NSIndexPath], thirdPlane: [NSIndexPath], planeImageView : UIImageView, myPlaneArray: [NSIndexPath], headArray : [NSIndexPath]) {
        
//        for index in firstPlane {
//            (self.collectionView!.cellForItemAtIndexPath(index) as! MyCollectionViewCell).status = 1
//        }
//        for index in secondPlane {
//            (self.collectionView!.cellForItemAtIndexPath(index) as! MyCollectionViewCell).status = 2
//        }
//        for index in thirdPlane {
//            (self.collectionView!.cellForItemAtIndexPath(index) as! MyCollectionViewCell).status = 3
//        }
        
        myPlane = myPlaneArray
        myHearArray = headArray
        
        // 1. 开启一个图片的图形上下文
        UIGraphicsBeginImageContextWithOptions(collectionView!.frame.size, false, 0.0)
        
        // 3. 把原图片绘制到上下文中
        imageIcon.drawInRect((collectionView?.frame)!)
        
        planeImageView.image!.drawInRect((collectionView?.frame)!)
        
        // 4. 从图形上下文中取出图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
        
        collectionView!.layer.contents = image.CGImage
        
    }
    
    func clearMyPlane (planeArray : [NSIndexPath]) {
        
        collectionView!.layer.contents = imageIcon.CGImage
        
        attackCount = 0
        myHearArray.removeAll()
        for index in 0...80 {
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            (self.collectionView!.cellForItemAtIndexPath(indexPath) as! MyCollectionViewCell).status = 0
            (self.collectionView!.cellForItemAtIndexPath(indexPath) as! MyCollectionViewCell).hit = 0
        }
    }
    
    
    
    //MARK: 单机的方法
    func solitaireGame(difficulty: Int , headArray : [NSIndexPath]) {
        
        if attackCount == difficulty {
            
            (collectionView?.cellForItemAtIndexPath(myHearArray.last!) as! MyCollectionViewCell).hit = 1
            myHearArray.removeLast()
            
            if myHearArray.count == 0 {
                self.myPlaneDelegate?.result(false)
            }
            
        } else {
            
            attackCount++
            
            
            let firstPoint = Int(arc4random_uniform(75) + 3)
            
            let index = NSIndexPath(forItem: firstPoint, inSection: 0)
            
            if (collectionView?.cellForItemAtIndexPath(index) as! MyCollectionViewCell).hit == 0 {
                
                for indexPlane in myPlane {
                    
                    if indexPlane == index {
                        
                        (collectionView?.cellForItemAtIndexPath(index) as! MyCollectionViewCell).hit = 2
                        break
                    } else {
                        (collectionView?.cellForItemAtIndexPath(index) as! MyCollectionViewCell).hit = 3
                    }
                    
                }
                
                
                for head in headArray {
                    var j = 0
                    j++
                    if index == head {
                        (collectionView?.cellForItemAtIndexPath(index) as! MyCollectionViewCell).hit = 1
                        myHearArray.removeAtIndex(j - 1)
                        if myHearArray.count == 0 {
                            self.myPlaneDelegate?.result(false)
                        }
                    }
                }
                
            } else {
                solitaireGame(difficulty, headArray: headArray)
            }
            
            
        }
        
    }
    
    /// 布局属性
    private let layout = MyFlowLayout()
    
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    /// 准备 CollectionView
    private func prepareCollectionView() {
        
        self.collectionView!.registerClass(MyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    /// 自定义流水布局
    private class MyFlowLayout: UICollectionViewFlowLayout {
        
        private override func prepareLayout() {
            minimumLineSpacing = 0
            minimumInteritemSpacing = 0
            let wh = collectionView!.bounds.width / 9.0
            itemSize =  CGSize(width: wh, height: wh)
            collectionView?.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
            as! MyCollectionViewCell
        
        
        return cell
    }
}


private class MyCollectionViewCell: UICollectionViewCell {
    
    var isHead : Bool = false
    
    var status : Int = 0 {
        
        didSet {
            
            switch status {
            case 1 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: "purple"), forState: UIControlState.Highlighted)
            case 2 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: "red"), forState: UIControlState.Highlighted)
            case 3 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: "green"), forState: UIControlState.Highlighted)
            case 4 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Highlighted)
            default :
                viewBtn.selected = false
                viewBtn.highlighted = false
                viewBtn.backgroundColor = UIColor.clearColor()
                
            }
        }
    }
    
    var hit : Int = 0 {
        didSet {
            
            switch hit {
            case 1 :
                viewBtn.selected = true
                viewBtn.highlighted = false
                viewBtn.setImage(UIImage(named: "die"), forState: UIControlState.Selected)
            case 2 :
                viewBtn.selected = true
                viewBtn.highlighted = false
                viewBtn.setImage(UIImage(named: "fuselage"), forState: UIControlState.Selected)
            case 3 :
                viewBtn.selected = true
                viewBtn.setImage(UIImage(named: "noBuy"), forState: UIControlState.Selected)
            default :
                viewBtn.selected = false
                viewBtn.highlighted = false
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(viewBtn)
        viewBtn.userInteractionEnabled = false
        viewBtn.frame = contentView.frame
        viewBtn.frame = CGRectInset(bounds, 0.5 , 0.5)
    }
    private lazy var viewBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clearColor()
        //        btn.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Normal)
        //        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Selected)
        //        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Disabled)
        
        return btn
        }()
    
}


