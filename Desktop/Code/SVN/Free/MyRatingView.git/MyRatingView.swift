//
//  MyRatingView.swift
//  Mobo
//
//  Created by ME on 3/22/15.
//  Copyright (c) 2015 Nam Truong. All rights reserved.
//

import UIKit

enum RATE_ALIGNMENT {
    case LEFT
    case RIGHT
    case CENTER
}

class MyRatingView: UIView {
    var currentValue : CGFloat = 0
    var maxRate : Int = 0
    func setRate(rate : CGFloat,maxRate : Int,normalImage : String,selectedImage : String,align : RATE_ALIGNMENT,isCanTouch : Bool,space : CGFloat = 0,masks : Bool = false){
        self.userInteractionEnabled = isCanTouch
        //self.backgroundColor = UIColor.clearColor()
        currentValue = rate
        self.maxRate = maxRate
        let h = self.frame.size.height
        var xBegin : CGFloat = 0
        if align == RATE_ALIGNMENT.CENTER {
            xBegin = self.frame.size.width/2
            xBegin -= (h * CGFloat(maxRate))/2
            xBegin -= (space * (CGFloat(maxRate-1)))/2
        }else if align == RATE_ALIGNMENT.RIGHT {
            xBegin = (self.frame.size.width) - h * CGFloat(maxRate) -  space * CGFloat(maxRate-1))
        }
        
//        for view in self.subviews {
//            view.removeFromSuperview()
//        }
        self.viewWithTag(100)?.removeFromSuperview()
        for i in 0..<maxRate {
            var btn = self.viewWithTag(i+1) as? UIButton
            if btn == nil {
                btn = UIButton(frame: CGRectMake(xBegin + CGFloat(i) * (h+space), 0, h, h))
                btn!.addTarget(self, action: "changeRate:", forControlEvents: UIControlEvents.TouchUpInside)
                btn!.tag = i+1
                self.addSubview(btn!)
            }
            btn!.setImage(UIImage(named: normalImage), forState: UIControlState.Normal)
            btn!.setImage(UIImage(named: selectedImage), forState: UIControlState.Selected)
            btn!.layer.mask = nil
            if currentValue >= CGFloat(i+1) {
                btn!.selected = true
            }else{
                btn!.selected = false
                if masks == true{
                    let per = currentValue - CGFloat(i)
                    if per > 0 {
                        var btnBackground = self.viewWithTag(100) as?  UIButton
                        if btnBackground == nil {
                            btnBackground = UIButton(frame: CGRectMake(xBegin + CGFloat(i) * (h+space), 0, h, h))
                            btnBackground!.tag = 100
                            self.addSubview(btnBackground!)
                            btnBackground!.setImage(UIImage(named: normalImage), forState: UIControlState.Disabled)
                            btnBackground!.enabled = false
                        }
                        
                        btn!.selected = true
                        let rect = CGRectMake(0, 0, h*per, h)
                        let mask = CAShapeLayer()
                        let path = CGPathCreateWithRect(rect,nil)
                        mask.path = path
                        btn!.layer.mask = mask
                    }
                }
            }
        }
    }
    
    func changeRate(sender : UIButton){
        if sender.selected == false {
            sender.selected = true
        }
        currentValue = CGFloat(sender.tag)
        for i in 1...self.maxRate{
            let btn = self.viewWithTag(i) as? UIButton
            if btn != nil {
                btn!.selected = (i <= sender.tag)
            }
        }
    }
}
