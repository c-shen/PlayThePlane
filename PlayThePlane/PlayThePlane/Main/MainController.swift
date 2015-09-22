//
//  MainController.swift
//  Play the plane
//
//  Created by Aiya on 15/8/20.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit
import SVProgressHUD
import iAd


private let reuseIdentifier = "Cell"

class MainController: UIViewController {
    
    var pattern = 1
    private let isMyP: MyPlaneCollectionViewControler = MyPlaneCollectionViewControler()
    private let model: planeModel = planeModel()
    private var first = NSIndexPath?()
    private var isMy = true
    private var plane = 1
    private var planeArray = [NSIndexPath]()
    private var headArray = [NSIndexPath]()
    private var firstPlane = [NSIndexPath]()
    private var secondPlane = [NSIndexPath]()
    private var thirdPlane = [NSIndexPath]()
    private var WinInt = 0
    private var attack = NSIndexPath?()
    private var difficulty = 0
    private var planeHeadFrame = CGRect()
    let wa = UIScreen.mainScreen().bounds.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        isMyP.myPlaneDelegate = self
    }
    
    
    
    
    //MARK: 按钮方法
    @objc func secedeGame() {
        
        let alert = UIAlertController(title: "提示", message: "亲您确定要退出吗", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: { (_) -> Void in
            self.dismiss()
            
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Destructive, handler: { (_) -> Void in
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc func selectDifficultyGame() {
        
        let alert = UIAlertController(title: "选择难度", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "菜鸟级", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            self.difficulty = 20
        }))
        
        alert.addAction(UIAlertAction(title: "初级", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            self.difficulty = 10
        }))
        
        alert.addAction(UIAlertAction(title: "中级", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            self.difficulty = 5
        }))
        
        alert.addAction(UIAlertAction(title: "高级", style: UIAlertActionStyle.Default, handler: { (_) -> Void in
            self.difficulty = 2
        }))
        
        alert.addAction(UIAlertAction(title: "神级", style: UIAlertActionStyle.Destructive, handler: { (_) -> Void in
            self.difficulty = 1
        }))
        
        alert.addAction(UIAlertAction(title: "外挂级", style: UIAlertActionStyle.Destructive, handler: { (_) -> Void in
            self.difficulty = 0
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @objc func backoutGame() {
        enemyCollectionView.subviews.last?.removeFromSuperview()
        if isMy {
            if first != nil {
                first = nil
                let vc = view.subviews.last
                vc?.removeFromSuperview()
            } else {
                switch plane {
                case 2:
                    for index in firstPlane {
                        (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 0
                    }
                    plane -= 1
                    let myPlane = enemyCollectionView.subviews.last
                    myPlane?.removeFromSuperview()
                    firstPlane.removeAll()
                case 3:
                    for index in secondPlane {
                        (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 0
                    }
                    plane -= 1
                    let myPlane = enemyCollectionView.subviews.last
                    myPlane?.removeFromSuperview()
                    secondPlane.removeAll()
                case 4:
                    for index in thirdPlane {
                        (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 0
                    }
                    plane -= 1
                    let myPlane = enemyCollectionView.subviews.last
                    myPlane?.removeFromSuperview()
                    thirdPlane.removeAll()
                default:0
                }
                planeArray.removeAll()
                planeArray += firstPlane
                planeArray += secondPlane
                planeArray += thirdPlane
            }
        }
    }
    
    
    @objc func playGame() {
        
        if planeArray.count > 32 {
            
            contextIconView()
            view.userInteractionEnabled = false
            if isMy == true {
                for index in planeArray {
                    (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 0
                }
                isMy = false
                if pattern == 1 {
                    model.removeArray()
                    model.setPlane()
                    addEnemyPlane(model.firstPlane, secondPlane: model.secondPlane, thirdPlane: model.thirdPlane)
                    
                } else {
                    
                    
                }
                
                
            } else {
                
                
            }
        }
    }
    
    func addEnemyPlane(firstPlane: [NSIndexPath], secondPlane: [NSIndexPath], thirdPlane: [NSIndexPath]) {
        
        for index in firstPlane {
            (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 4}
        for index in secondPlane {
            (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 4}
        for index in thirdPlane {
            (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 4}
    }
    
    
    private func overGame() {
        
        planeArray.removeAll()
        
        for i in 0...2 {
            
            let firstindex = model.headArray[i]
            let secondindex = model.secondArray[i]
            let x1 = firstindex.item / 9
            let x2 = secondindex.item / 9
            let y1 = firstindex.item % 9
            let y2 = secondindex.item % 9
            planeHeadFrame = (enemyCollectionView.cellForItemAtIndexPath(firstindex)?.frame)!
            
            if x1 == x2 {
                if y1 > y2 {
                    let myPlane = UIImageView(image: UIImage(named: "plane"))
                    myPlane.frame = planeCalculate(wa / 9, cellContx: 3, cellConty: 2,widthCont: 4, heightCont: 5)
                    myPlane.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    enemyCollectionView.addSubview(myPlane)
                    
                } else {
                    let myPlane = UIImageView(image: UIImage(named: "plane"))
                    myPlane.frame = planeCalculate(wa / 9, cellContx: 0, cellConty: 2, widthCont: 4, heightCont: 5)
                    enemyCollectionView.addSubview(myPlane)
                }
                
            } else if y1 == y2 {
                
                if x1 > x2 {
                    let myPlane = UIImageView(image: UIImage(named: "plane2"))
                    myPlane.frame = planeCalculate(wa / 9, cellContx: 2, cellConty: 3, widthCont: 5, heightCont: 4)
                    myPlane.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    enemyCollectionView.addSubview(myPlane)
                    
                } else {
                    let myPlane = UIImageView(image: UIImage(named: "plane2"))
                    myPlane.frame = planeCalculate(wa / 9, cellContx: 2, cellConty: 0, widthCont: 5, heightCont: 4)
                    enemyCollectionView.addSubview(myPlane)
                    
                }
            }
        }
        // 1. 开启一个图片的图形上下文
        UIGraphicsBeginImageContextWithOptions(enemyCollectionView.frame.size, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext();
        
        enemyCollectionView.layer.renderInContext(ctx!)
        
        // 4. 从图形上下文中取出图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
        
        enemyCollectionView.layer.contents = image.CGImage
        
        for _ in 0...2 {
            enemyCollectionView.subviews.last?.removeFromSuperview()
        }
    }
    
    
    
    private func contextIconView() {
        // 1. 开启一个图片的图形上下文
        UIGraphicsBeginImageContextWithOptions(enemyCollectionView.frame.size, false, 0.0)
        // 获取当前图形上下文
        let ctx = UIGraphicsGetCurrentContext();
        
        // 2. 把绘图View中的内容渲染到图形上下文中
        enemyCollectionView.layer.renderInContext(ctx!)
        
        // 3. 从图形上下文中取出图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
        
        let iconView: UIImageView = UIImageView()
        iconView.image = image
        iconView.frame = enemyCollectionView.frame
        view.addSubview(iconView)
        
        UIView.animateWithDuration(2.5, animations: { () -> Void in
            
            iconView.frame = self.isMyP.view.frame
            
            for _ in 0...2 {
                self.enemyCollectionView.subviews.last?.removeFromSuperview()
            }
            
            }) { (_) -> Void in
                self.view.userInteractionEnabled = true
                self.isMyP.addMyPlane(self.firstPlane, secondPlane: self.secondPlane, thirdPlane: self.thirdPlane, planeImageView: iconView, myPlaneArray: self.planeArray)
                self.isMyP.view.hidden = false
                self.setupMyUI()
                iconView.removeFromSuperview()
        }
        
    }
    
    
    
    //MARK: 九宫格按钮
    
    private func addPlane(textPlane: [NSIndexPath], first: NSIndexPath) {
        
        for index in textPlane {
            for indexpath in planeArray {
                if indexpath == index {
                    enemyCollectionView.subviews.last?.removeFromSuperview()
                    SVProgressHUD.showInfoWithStatus("飞机重叠,请重新添加", maskType: SVProgressHUDMaskType.Clear)
                    return
                }
            }
        }
        
        planeArray += textPlane
        switch plane {
        case 1 :
            firstPlane = textPlane
            for index in firstPlane {
                (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = plane
            }
        case 2 :
            secondPlane = textPlane
            for index in secondPlane {
                (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = plane
            }
        case 3 :
            thirdPlane = textPlane
            for index in thirdPlane {
                (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = plane
            }
        default : return
        }
        headArray.append(first)
        plane += 1
        (enemyCollectionView.cellForItemAtIndexPath(first) as! enemyCollectionViewCell).isHead = true
        
    }
    
    private func crosswise(first: NSIndexPath) {
        
        var textPlane = [NSIndexPath]()
        
        for var i = first.item ;i > first.item - 4 ;i-- {
            let index = NSIndexPath(forItem: i, inSection: 0)
            textPlane.append(index)
            if i == (first.item - 1) {
                for var j = i + 9 ; j <= i + 18 ; j += 9 {
                    let indexj = NSIndexPath(forItem: j, inSection: 0)
                    textPlane.append(indexj)
                    
                }
                for var k = i - 9 ; k >= i - 18 ; k -= 9{
                    let indexk = NSIndexPath(forItem: k, inSection: 0)
                    textPlane.append(indexk)
                }
                
            } else if i == (first.item - 3) {
                
                let indexi = NSIndexPath(forItem: i + 9, inSection: 0)
                let indexi2 = NSIndexPath(forItem: i - 9, inSection: 0)
                
                textPlane.append(indexi)
                textPlane.append(indexi2)
                
            }
        }
        
        let myPlane = UIImageView(image: UIImage(named: "plane"))
        myPlane.frame = planeCalculate(wa / 9, cellContx: 3, cellConty: 2,widthCont: 4, heightCont: 5)
        myPlane.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        enemyCollectionView.addSubview(myPlane)
        
        addPlane(textPlane, first: first)
    }
    private func crosswiseLess(first: NSIndexPath) {
        
        var textPlane = [NSIndexPath]()
        
        for var i = first.item ;i < first.item + 4 ;i++ {
            let index = NSIndexPath(forItem: i, inSection: 0)
            textPlane.append(index)
            
            if i == first.item + 1 {
                for var j = i ; j <= i + 18 ; j += 9 {
                    let indexj = NSIndexPath(forItem: j, inSection: 0)
                    textPlane.append(indexj)
                    
                }
                for var k = i ; k >= i - 18 ; k -= 9{
                    let indexk = NSIndexPath(forItem: k, inSection: 0)
                    textPlane.append(indexk)
                    
                }
                
            } else if i == first.item + 3 {
                
                let indexi = NSIndexPath(forItem: i + 9, inSection: 0)
                let indexi2 = NSIndexPath(forItem: i - 9, inSection: 0)
                
                textPlane.append(indexi)
                textPlane.append(indexi2)
            }
        }
        
        let myPlane = UIImageView(image: UIImage(named: "plane"))
        myPlane.frame = planeCalculate(wa / 9, cellContx: 0, cellConty: 2, widthCont: 4, heightCont: 5)
        enemyCollectionView.addSubview(myPlane)
        
        addPlane(textPlane, first: first)
    }
    
    
    private func lengthways(first: NSIndexPath) {
        
        var textPlane = [NSIndexPath]()
        
        for var i = first.item ;i > first.item - 36 ;i -= 9 {
            
            let index = NSIndexPath(forItem: i, inSection: 0)
            textPlane.append(index)
            
            if i == (first.item - 9) {
                for var j = i ; j <= i + 2 ; j++ {
                    let indexj = NSIndexPath(forItem: j, inSection: 0)
                    textPlane.append(indexj)
                    
                }
                for var k = i ; k >= i - 2 ; k-- {
                    let indexk = NSIndexPath(forItem: k, inSection: 0)
                    textPlane.append(indexk)
                }
                
            } else if i == (first.item - 27) {
                
                let indexi = NSIndexPath(forItem: i + 1, inSection: 0)
                let indexi2 = NSIndexPath(forItem: i - 1, inSection: 0)
                
                textPlane.append(indexi)
                textPlane.append(indexi2)
                
            }
        }
        
        let myPlane = UIImageView(image: UIImage(named: "plane2"))
        myPlane.frame = planeCalculate(wa / 9, cellContx: 2, cellConty: 3, widthCont: 5, heightCont: 4)
        myPlane.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        enemyCollectionView.addSubview(myPlane)
        
        addPlane(textPlane, first: first)
        
    }
    private func lengthwaysLess(first: NSIndexPath) {
        
        var textPlane = [NSIndexPath]()
        
        for var i = first.item ;i < first.item + 36 ;i += 9 {
            let index = NSIndexPath(forItem: i, inSection: 0)
            textPlane.append(index)
            
            if i == (first.item + 9) {
                for var j = i ; j <= i + 2 ; j++ {
                    let indexj = NSIndexPath(forItem: j, inSection: 0)
                    textPlane.append(indexj)
                    
                }
                for var k = i ; k >= i - 2 ; k-- {
                    let indexk = NSIndexPath(forItem: k, inSection: 0)
                    textPlane.append(indexk)
                }
                
            } else if i == (first.item + 27) {
                
                let indexi = NSIndexPath(forItem: i + 1, inSection: 0)
                let indexi2 = NSIndexPath(forItem: i - 1, inSection: 0)
                
                textPlane.append(indexi)
                textPlane.append(indexi2)
                
            }
        }
        
        let myPlane = UIImageView(image: UIImage(named: "plane2"))
        myPlane.frame = planeCalculate(wa / 9, cellContx: 2, cellConty: 0, widthCont: 5, heightCont: 4)
        enemyCollectionView.addSubview(myPlane)
        
        addPlane(textPlane, first: first)
        
    }
    
    private func crossingLine(collectionView: UIView) {
        
        first = nil
        let vc = view.subviews.last
        vc?.removeFromSuperview()
        //        enemyCollectionView.subviews.last?.removeFromSuperview()
        SVProgressHUD.showInfoWithStatus("超出边界,请重新选择", maskType: SVProgressHUDMaskType.Clear)
    }
    
    //MARK : 计算飞机的frame
    private func planeCalculate(cellwh: CGFloat, cellContx: CGFloat, cellConty: CGFloat,widthCont: CGFloat, heightCont: CGFloat) -> (CGRect) {
        
        let x = planeHeadFrame.origin.x - cellwh * cellContx
        let y = planeHeadFrame.origin.y - cellwh * cellConty
        let width = cellwh * widthCont
        let height = cellwh * heightCont
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    private func drawPlane(indexPath: NSIndexPath, collectionView: UIView,firstCell: UICollectionViewCell) {
        
        if (first != nil) {
            
            let second = indexPath
            let x1 = first!.item / 9
            let x2 = second.item / 9
            let y1 = first!.item % 9
            let y2 = second.item % 9
            
            if x1 == x2 {
                
                if y1 > y2 {
                    
                    if x1 < 2 {
                        return crossingLine(collectionView)
                    } else if x1 > 6 {
                        return crossingLine(collectionView)
                    } else if y1 < 3 {
                        return crossingLine(collectionView)
                    } else if y1 > 8 {
                        return crossingLine(collectionView)
                    }
                    crosswise(first!)
                    
                } else {
                    
                    if x1 < 2 {
                        return crossingLine(collectionView)
                    } else if x1 > 6 {
                        return crossingLine(collectionView)
                    } else if y1 < 0 {
                        return crossingLine(collectionView)
                    } else if y1 > 5 {
                        return crossingLine(collectionView)
                    }
                    crosswiseLess(first!)
                    
                }
                
            } else if y1 == y2 {
                
                if x1 > x2 {
                    
                    if y1 < 2 {
                        return crossingLine(collectionView)
                    } else if y1 > 6 {
                        return crossingLine(collectionView)
                    } else if x1 < 3 {
                        return crossingLine(collectionView)
                    } else if x1 > 8 {
                        return crossingLine(collectionView)
                    }
                    lengthways(first!)
                    
                } else {
                    if y1 < 2 {
                        return crossingLine(collectionView)
                    } else if y1 > 6 {
                        return crossingLine(collectionView)
                    } else if x1 < 0 {
                        return crossingLine(collectionView)
                    } else if x1 > 5 {
                        return crossingLine(collectionView)
                    }
                    lengthwaysLess(first!)
                    
                }
                
                
            } else {
                
                SVProgressHUD.showInfoWithStatus("选取错误,请重新选择", maskType: SVProgressHUDMaskType.Clear)
            }
            first = nil
            let vc = view.subviews.last
            vc?.removeFromSuperview()
            //            enemyCollectionView.subviews
            
            
            
        } else {
            // 获取被点击的cell
            first = indexPath
            let vc = UIImageView(image: UIImage(named: "add"))
            let cell = firstCell
            vc.frame = cell.frame
            planeHeadFrame = cell.frame
            view.addSubview(vc)
        }
    }
    
    
    private func attack(cell: enemyCollectionViewCell, indexPath: NSIndexPath) {
        
        if cell.status != 0 {
            cell.hit = 2
        } else {
            cell.hit = 3
        }
        
        for hitCell in model.headArray {
            
            if indexPath == hitCell {
                cell.hit = 1
                WinInt++
            }
        }
        if WinInt == 3 {
            
            result(true)
            return
        }
        isMyP.solitaireGame(difficulty, headArray: headArray)
    }
    
    
    private func clearAll() {
        
        isMy = true
        WinInt = 0
        plane = 1
        planeArray.removeAll()
        headArray.removeAll()
        firstPlane.removeAll()
        secondPlane.removeAll()
        thirdPlane.removeAll()
        first = nil
        enemyCollectionView.layer.contents = UIColor.clearColor()
        
        
        for i in 1...79 {
            let index = NSIndexPath(forItem: i, inSection: 0)
            (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).status = 0
            (enemyCollectionView.cellForItemAtIndexPath(index) as! enemyCollectionViewCell).hit = 0
        }
        
        
    }
    
    
    private func setupUI() {
        
        let wm = UIScreen.mainScreen().bounds.width - wa
        print(UIScreen.mainScreen().bounds)
        
        view.layer.contents = UIImage(named: "background")!.CGImage
        
        enemyCollectionView.frame = CGRect(x: 0, y: 0, width: wa, height: wa)
        isMyP.view.frame = CGRect(x: wa, y: 0, width:wm , height: wm)
        MyiAd.view.frame = CGRect(x: wa, y: wa - 30, width: wm, height: 30)
        
        view.addSubview(imageView)
        view.addSubview(enemyCollectionView)
        view.addSubview(MyiAd.view)
        view.addSubview(isMyP.view)
        view.addSubview(secede)
        view.addSubview(selectDifficulty)
        view.addSubview(backout)
        view.addSubview(play)
        
        isMyP.view.hidden = true
        imageView.frame = isMyP.view.frame
        
        let space = (wm - 60 * 4) / 5
        secede.frame = CGRect(x: wa + space, y: wa - 70, width: 60, height: 40)
        selectDifficulty.frame = CGRect(x: wa + 2 * space + 60, y: wa - 70, width: 60, height: 40)
        backout.frame = CGRect(x: wa + 3 * space + 120, y: wa - 70, width: 60, height: 40)
        play.frame = CGRect(x: wa + 4 * space + 180, y: wa - 70, width: 60, height: 40)
        
        //        let dict = ["acv" : enemyCollectionView, "backout" : backout, "secede" : secede, "play" : play, "imageView" : imageView , "selectDifficulty" : selectDifficulty]
        //
        //        secede.translatesAutoresizingMaskIntoConstraints = false
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[acv]-(10)-[secede(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[imageView]-10-[secede]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        selectDifficulty.translatesAutoresizingMaskIntoConstraints = false
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[secede]-(20)-[selectDifficulty(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[imageView]-10-[selectDifficulty]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        backout.translatesAutoresizingMaskIntoConstraints = false
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[selectDifficulty]-(10)-[backout(60)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[imageView]-10-[backout]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        play.translatesAutoresizingMaskIntoConstraints = false
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[backout]-(10)-[play(60)]-(10)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        //        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[imageView]-10-[play]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        
        selectDifficulty.addTarget(self, action: "selectDifficultyGame", forControlEvents: UIControlEvents.TouchUpInside)
        secede.addTarget(self, action: "secedeGame", forControlEvents: UIControlEvents.TouchUpInside)
        backout.addTarget(self, action: "backoutGame", forControlEvents: UIControlEvents.TouchUpInside)
        play.addTarget(self, action: "playGame", forControlEvents: UIControlEvents.TouchUpInside)
        
        prepareCollectionView()
        
        for i in 0...9 {
            let blackView: UIView = UIView()
            view.addSubview(blackView)
            blackView.frame = CGRect(x: CGFloat(i) * wa / 9, y: 0, width: 0.5, height: wa)
            blackView.backgroundColor = UIColor.blackColor()
        }
        for i in 0...9  {
            let blackView: UIView = UIView()
            view.addSubview(blackView)
            blackView.frame = CGRect(x: 0, y: CGFloat(i) * wa / 9, width: wa, height: 0.5)
            blackView.backgroundColor = UIColor.blackColor()
        }
        
    }
    
    private func setupMyUI() {
        
        let wm = UIScreen.mainScreen().bounds.width - wa
        
        for i in 0...9 {
            let blackView: UIView = UIView()
            view.addSubview(blackView)
            blackView.frame = CGRect(x: CGFloat(i) * wm / 9 + wa, y: 0, width: 0.5, height: wm)
            blackView.backgroundColor = UIColor.blackColor()
        }
        for i in 0...9  {
            let blackView: UIView = UIView()
            view.addSubview(blackView)
            blackView.frame = CGRect(x: wa, y: CGFloat(i) * wm / 9, width: wm, height: 0.5)
            blackView.backgroundColor = UIColor.blackColor()
        }
    }
    
    
    //MARK :collection准备
    private func prepareCollectionView() {
        enemyCollectionView.registerClass(enemyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        enemyCollectionView.delegate = self
        enemyCollectionView.dataSource = self
    }
    
    
    //MARK: 懒加载
    
    private lazy var enemyCollectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: EmoticonLayout())
    private lazy var imageView: UIImageView = UIImageView()
    private lazy var MyiAd: iAdViewController = iAdViewController()
    private lazy var secede: UIButton = UIButton(title: "退出", imageName: "btn2", fontSize: 15, width: 0 , height: 0, color: UIColor.whiteColor())
    private lazy var selectDifficulty: UIButton = UIButton(title: "选择难度", imageName: "btn2", fontSize: 15, width: 0 , height: 0, color: UIColor.whiteColor())
    private lazy var backout: UIButton = UIButton(title: "撤销", imageName: "btn2", fontSize: 15, width: 0 , height: 0, color: UIColor.whiteColor())
    private lazy var play: UIButton = UIButton(title: "确定", imageName: "btn2", fontSize: 15, width: 0 , height: 0, color: UIColor.whiteColor())
    //MARK:私有类方法
    private class EmoticonLayout: UICollectionViewFlowLayout {
        
        private override func prepareLayout() {
            minimumLineSpacing = 0
            minimumInteritemSpacing = 0
            let wh = collectionView!.bounds.width / 9.0
            itemSize =  CGSize(width: wh, height: wh)
            collectionView?.showsHorizontalScrollIndicator = false
            collectionView!.backgroundColor = UIColor.clearColor()
        }
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension MainController: UICollectionViewDataSource, UICollectionViewDelegate, MyPlaneCollectionViewControlerDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if plane == 4 && isMy == true {
            return
        }
        for i in planeArray {
            if indexPath == i && isMy == true && first != i {
                SVProgressHUD.showInfoWithStatus("选取重复,请重新选择", maskType: SVProgressHUDMaskType.Clear)
                return
            }
        }
        
        if first == indexPath {
            first = nil
            let vc = view.subviews.last
            vc?.removeFromSuperview()
            SVProgressHUD.showInfoWithStatus("选取重复,请重新选择", maskType: SVProgressHUDMaskType.Clear)
            return
        }
        
        
        if plane < 4 {
            
            let firstCell = collectionView.cellForItemAtIndexPath(indexPath)!
            
            drawPlane(indexPath, collectionView: collectionView, firstCell: firstCell)
            
        } else {
            if isMy != true {
                
                let cell = (collectionView.cellForItemAtIndexPath(indexPath)) as! enemyCollectionViewCell!
                
                if cell.hit != 0 {
                    SVProgressHUD.showInfoWithStatus("您已经攻击过该位置了!", maskType: SVProgressHUDMaskType.Clear)
                    return
                }
                
                attack(cell, indexPath: indexPath)
                
            }
        }
        
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
            as! enemyCollectionViewCell
        
        
        return cell
    }
    
    
    func result(standard: Bool) {
        
        overGame()
        
        let alert = UIAlertController(title: standard ? "恭喜您" : "很遗憾", message: standard ? "您获得了胜利!" : "您失败了!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive, handler: { (_) -> Void in
            
            self.isMyP.clearMyPlane(self.planeArray)
            self.clearAll()
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

//MARK:自定义cell
private class enemyCollectionViewCell: UICollectionViewCell {
    
    var isHead : Bool = false
    
    var status : Int = 0 {
        
        didSet {
            
            switch status {
            case 1 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: "die"), forState: UIControlState.Highlighted)
            case 2 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: "fuselage"), forState: UIControlState.Highlighted)
            case 3 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: "noBuy"), forState: UIControlState.Highlighted)
            case 4 :
                viewBtn.highlighted = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                //                viewBtn.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Highlighted)
            default :
                viewBtn.selected = false
                viewBtn.highlighted = false
                //                viewBtn.backgroundColor = UIColor.clearColor()
                
            }
        }
    }
    
    var hit : Int = 0 {
        didSet {
            
            switch hit {
            case 1 :
                viewBtn.selected = true
                viewBtn.highlighted = false
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                viewBtn.setImage(UIImage(named: "die"), forState: UIControlState.Selected)
            case 2 :
                viewBtn.selected = true
                viewBtn.highlighted = false
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                viewBtn.setImage(UIImage(named: "fuselage"), forState: UIControlState.Selected)
            case 3 :
                viewBtn.selected = true
                //                viewBtn.backgroundColor = UIColor.whiteColor()
                viewBtn.setImage(UIImage(named: "noBuy"), forState: UIControlState.Selected)
            default :
                viewBtn.selected = false
                viewBtn.highlighted = false
                viewBtn.backgroundColor = UIColor.clearColor()
                
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.backgroundColor = UIColor.clearColor()
        setupUI()
        viewBtn.userInteractionEnabled = false;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(viewBtn)
        
        viewBtn.frame = contentView.frame
        viewBtn.frame = CGRectInset(bounds, 0.5 , 0.5)
    }
    private lazy var viewBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clearColor()
        //        btn.setBackgroundImage(UIImage(named: ""), forState: UIControlState.Normal)
        //        btn.setBackgroundImage(UIImage(named: "blue"), forState: UIControlState.Selected)
        //        btn.setBackgroundImage(UIImage(named: "red"), forState: UIControlState.Highlighted)
        return btn
        }()
    
}
