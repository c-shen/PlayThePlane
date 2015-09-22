//
//  plane.swift
//  PlayThePlane
//
//  Created by Aiya on 15/8/28.
//  Copyright © 2015年 aiya. All rights reserved.
//

import UIKit
import SVProgressHUD


class planeModel: NSObject {
    
    private var plane = 1
    var planeArray = [NSIndexPath]()
    var headArray = [NSIndexPath]()
    var secondArray = [NSIndexPath]()
    var firstPlane = [NSIndexPath]()
    var secondPlane = [NSIndexPath]()
    var thirdPlane = [NSIndexPath]()
    
    
    
    override init() {
        super.init()
        
    }
    
    
    func removeArray() {
        
        plane = 1
        planeArray.removeAll()
        headArray.removeAll()
        secondArray.removeAll()
        firstPlane.removeAll()
        secondPlane.removeAll()
        thirdPlane.removeAll()
        
    }
    
    
    func setPlane() {
        
        
        for i in 0...30 {
            
            let firstPoint = Int(arc4random_uniform(78) + 2)
            
            let array = [(firstPoint - 1) , (firstPoint + 1), (firstPoint - 9), (firstPoint + 9)]
            let second = Int(arc4random_uniform(4) + 0)
            
            let first = NSIndexPath(forItem: firstPoint, inSection: 0)
            let indexPath = NSIndexPath(forItem: array[second], inSection: 0)
            
            drawPlane(indexPath, first: first, second: indexPath)
            
            if thirdPlane.count != 0 {
                
                return
            }
            
            if i == 29 && thirdPlane.count == 0 {
                removeArray()
                setPlane()
                return
            }
        }
        
    }
    
    
    //MARK: 九宫格按钮
    
    private func addPlane(textPlane: [NSIndexPath], first: NSIndexPath, second: NSIndexPath) {
        
        for index in textPlane {
            for indexpath in planeArray {
                if indexpath == index {
                    return
                }
            }
        }
        
        planeArray += textPlane
        switch plane {
        case 1 :
            firstPlane = textPlane
        case 2 :
            secondPlane = textPlane
        case 3 :
            thirdPlane = textPlane
        default : 0
        }
        
        headArray.append(first)
        secondArray.append(second)
        plane += 1
    }
    
    private func crosswise(first: NSIndexPath, second: NSIndexPath) {
        
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
        
        addPlane(textPlane, first: first, second: second)
    }
    private func crosswiseLess(first: NSIndexPath, second: NSIndexPath) {
        
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
        
        addPlane(textPlane, first: first, second: second)
    }
    
    
    private func lengthways(first: NSIndexPath, second: NSIndexPath) {
        
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
        
        addPlane(textPlane, first: first, second: second)
        
    }
    private func lengthwaysLess(first: NSIndexPath, second: NSIndexPath) {
        
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
        addPlane(textPlane, first: first, second: second)
        
    }
    
    
    
    private func drawPlane(indexPath: NSIndexPath, first: NSIndexPath, second: NSIndexPath) {
        
        let second = indexPath
        let x1 = first.item / 9
        let x2 = second.item / 9
        let y1 = first.item % 9
        let y2 = second.item % 9
        
        if x1 == x2 {
            
            if y1 > y2 {
                
                if x1 < 2 {
                    return
                } else if x1 > 6 {
                    return
                } else if y1 < 3 {
                    return
                } else if y1 > 8 {
                    return
                }
                crosswise(first, second: second)
                
            } else {
                
                if x1 < 2 {
                    return
                } else if x1 > 6 {
                    return
                } else if y1 < 0 {
                    return
                } else if y1 > 5 {
                    return
                }
                crosswiseLess(first, second: second)
                
            }
            
        } else if y1 == y2 {
            
            if x1 > x2 {
                
                if y1 < 2 {
                    return
                } else if y1 > 6 {
                    return
                } else if x1 < 3 {
                    return
                } else if x1 > 8 {
                    return
                }
                lengthways(first, second: second)
                
            } else {
                if y1 < 2 {
                    return
                } else if y1 > 6 {
                    return
                } else if x1 < 0 {
                    return
                } else if x1 > 5 {
                    return
                }
                lengthwaysLess(first, second: second)
                
            }
        }
    }
}