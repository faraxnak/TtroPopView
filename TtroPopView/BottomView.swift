//
//  BottomView.swift
//  TtroPopView
//
//  Created by Farid on 2/5/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import EasyPeasy
import PayWandBasicElements

public protocol BottomViewDelegate {
    
    func onMiddleButton()
    
    func onLeftButton()
    
    func onRightButton()
    
    func bottomView(numberOfButtons : Int)
}

class BottomView: UIView {
    
    var delegate : BottomViewDelegate?
    
    convenience init(numberOfButtons n : Int?) {
        self.init(frame : .zero)
        initElements()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initElements(){
        let leftButton = UIButton(type: .system)
        addSubview(leftButton)
        leftButton <- [
            CenterX(),
            CenterY(),
            Width(*(1/3)).like(self)
        ]
        
        leftButton.setTitle("Cancel", for: UIControlState.normal)
        leftButton.titleLabel?.font = UIFont.TtroPayWandFonts.light3.font
        leftButton.setTitleColor(UIColor.TtroColors.lightBlue.color, for: UIControlState())
        leftButton.addTarget(self, action: #selector(self.onLeftButton), for: UIControlEvents.touchUpInside)
        
        let middleButton = UIButton(type: .system)
        addSubview(middleButton)
        middleButton <- [
            Right(),
            CenterY(),
            Width(*(1/3)).like(self)
        ]
        
        middleButton.setTitle("Delete", for: UIControlState.normal)
        middleButton.titleLabel?.font = UIFont.TtroPayWandFonts.light3.font
        middleButton.setTitleColor(UIColor.TtroColors.lightBlue.color, for: UIControlState())
        middleButton.addTarget(self, action: #selector(self.onMiddleButton), for: UIControlEvents.touchUpInside)
        
        let rightButton = UIButton(type: .system)
        addSubview(rightButton)
        rightButton <- [
            Left(),
            CenterY(),
            Width(*(1/3)).like(self)
        ]
        
        rightButton.setTitle("Save", for: UIControlState.normal)
        rightButton.titleLabel?.font = UIFont.TtroPayWandFonts.light3.font
        rightButton.setTitleColor(UIColor.TtroColors.lightBlue.color, for: UIControlState())
        //saveButton.addTarget(self, action: #selector(self.onSave(sender:)), for: UIControlEvents.touchUpInside)
        rightButton.addTarget(self, action: #selector(self.onRightButton), for: .touchUpInside)
        
        let firstVerSeparator = Separator(horizontal: false, superview: self, coeff: 0.8)
        firstVerSeparator <- [
            Right().to(rightButton, .right)
        ]
        firstVerSeparator.backgroundColor = UIColor.gray
        
        let secondVerSeparator = Separator(horizontal: false, superview: self, coeff: 0.8)
        secondVerSeparator <- [
            Left().to(middleButton, .left)
        ]
        secondVerSeparator.backgroundColor = UIColor.gray

    }
    
    func onLeftButton() {
        delegate?.onLeftButton()
    }
    
    func onMiddleButton() {
        delegate?.onMiddleButton()
    }
    
    func onRightButton() {
        delegate?.onRightButton()
    }
}

class Separator: UIView {
    
    convenience init(horizontal : Bool , superview : UIView, coeff: CGFloat){
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        alpha = 0.3
        self.backgroundColor = UIColor.TtroColors.white.color
        
        if (horizontal){
            self <- [
                Width(*coeff).like(superview),
                CenterX(),
                Height(1)
            ]
        } else {
            self <- [
                Width(1),
                Height(*coeff).like(superview),
                CenterY()
            ]
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


