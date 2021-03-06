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

@objc public protocol BottomViewDelegate {
    
    @objc optional func onSecondButton()
    
    @objc optional func onFirstButton()
    
    @objc optional func onThirdButton()
    
    @objc optional func bottomView(numberOfButtons bottomView : BottomView) -> Int
    
    func bottomView(listOfButtonTitles bottomView : BottomView, numberOfButtons n : Int) -> [String]
}

public class BottomView: UIView {
    
    var delegate : BottomViewDelegate!
    
    public convenience init(numberOfButtons n : Int?, delegate : BottomViewDelegate) {
        self.init(frame : .zero)
        self.delegate = delegate
        if (n != nil){
            initElements(numberOfButtons: n!)
        } else if let num = delegate.bottomView?(numberOfButtons: self) {
            initElements(numberOfButtons: num)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initElements(numberOfButtons n : Int){
        
        let stackedView = UIStackView()
        self.addSubview(stackedView)
        stackedView.easy.layout(Edges())
        
        stackedView.alignment = .center
        stackedView.axis = .horizontal
        stackedView.distribution = .fill
        
        let buttonTitles = delegate!.bottomView(listOfButtonTitles: self, numberOfButtons: n)
        
        let firstButton = UIButton(type: .system)
        firstButton.titleLabel?.font = UIFont.TtroPayWandFonts.light2.font
        firstButton.setTitleColor(UIColor.TtroColors.lightBlue.color, for: UIControlState())
        firstButton.addTarget(self, action: #selector(self.onFirstButton), for: UIControlEvents.touchUpInside)
        firstButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        firstButton <- Width(100)
        let secondButton = UIButton(type: .system)
        secondButton.titleLabel?.font = UIFont.TtroPayWandFonts.light2.font
        secondButton.setTitleColor(UIColor.TtroColors.lightBlue.color, for: UIControlState())
        secondButton.addTarget(self, action: #selector(self.onSecondButton), for: UIControlEvents.touchUpInside)
        secondButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        secondButton <- Width(100)
        let thirdButton = UIButton(type: .system)
        thirdButton.titleLabel?.font = UIFont.TtroPayWandFonts.light2.font
        thirdButton.setTitleColor(UIColor.TtroColors.lightBlue.color, for: UIControlState())
        thirdButton.addTarget(self, action: #selector(self.onThirdButton), for: .touchUpInside)
        thirdButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let horizontal = Separator(horizontal: true, superview: self, coeff: 0.95)
        horizontal.backgroundColor = UIColor.gray
        horizontal.easy.layout(Bottom(-5).to(self, .top).with(Priority.low))
        
        stackedView.addArrangedSubview(firstButton)
        firstButton.setTitle(buttonTitles[0], for: .normal)
        if (n > 1){
            let firstVerSeparator = Separator(horizontal: false, superview: nil, coeff: 0.8)
            stackedView.addArrangedSubview(firstVerSeparator)
            firstVerSeparator.easy.layout([
                Height(*0.8).like(stackedView)
            ])
            firstVerSeparator.backgroundColor = UIColor.gray
            stackedView.addArrangedSubview(firstVerSeparator)
            stackedView.addArrangedSubview(secondButton)
            secondButton.setTitle(buttonTitles[1], for: .normal)
            secondButton.easy.layout(Width().like(firstButton))
            horizontal.easy.layout(Bottom().to(firstVerSeparator, .top))
        }
        if (n > 2){
            let secondVerSeparator = Separator(horizontal: false, superview: nil, coeff: 0.8)
            stackedView.addArrangedSubview(secondVerSeparator)
            secondVerSeparator.easy.layout([
                Height(*0.8).like(stackedView)
            ])
            secondVerSeparator.backgroundColor = UIColor.gray
            stackedView.addArrangedSubview(secondVerSeparator)
            stackedView.addArrangedSubview(thirdButton)
            thirdButton.setTitle(buttonTitles[2], for: .normal)
            thirdButton.easy.layout(Width().like(secondButton))
        }
        if (n > 3 || n < 1){
            fatalError("Bottom view can be initiated with n between 1 to 3")
        }
    }
    
    @objc func onFirstButton() {
        delegate.onFirstButton?()
    }
    
    @objc func onSecondButton() {
        delegate.onSecondButton?()
    }
    
    @objc func onThirdButton() {
        delegate.onThirdButton?()
    }
}

class Separator: UIView {
    
    convenience init(horizontal : Bool, superview : UIView?, coeff: CGFloat){
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        alpha = 0.3
        self.backgroundColor = UIColor.TtroColors.white.color
        if (horizontal){
            self.easy.layout(Height(1))
        } else {
            self.easy.layout(Width(1))
        }
        if (superview != nil){
            superview!.addSubview(self)
            if (horizontal){
                self.easy.layout([
                    CenterX(),
                    Width(*coeff).like(superview!),
                ])
            } else {
                self.easy.layout([
                    Height(*coeff).like(superview!),
                    CenterY()
                ])
            }
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


