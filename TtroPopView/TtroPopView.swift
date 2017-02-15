//
//  TtroPopView.swift
//  TtroPopView
//
//  Created by Farid on 2/5/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import EasyPeasy
import PayWandBasicElements

public protocol TtroPopViewDelegate : BottomViewDelegate {
    
    func ttroPopView(numberOfViews popView : TtroPopView) -> Int
    
    func ttroPopView(numberOfViews popView : TtroPopView, viewAtIndex index : Int) -> UIView
}

public class TtroPopView: UIView {
    
    public var delegate : TtroPopViewDelegate!
    
    public var stackView : UIStackView!
    public var scrollView : UIScrollView!
    
    var titleLabel : TtroLabel!
    var bottomView : BottomView!
    
    convenience public init (title : String, delegate : TtroPopViewDelegate) {
        self.init(frame : .zero)
        self.delegate = delegate
        initElements(title : title)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initElements(title : String? = nil) {
        
        bottomView = BottomView(numberOfButtons: nil, delegate: delegate)
        self.addSubview(bottomView)
        bottomView <- [
            Height(40),
            Bottom(),
            Width().like(self),
            CenterX()
        ]
        
        titleLabel = TtroLabel(font: UIFont.TtroPayWandFonts.regular2.font, color: UIColor.TtroColors.lightBlue.color)
        titleLabel.text = title
        titleLabel.baselineAdjustment = .alignCenters
        addSubview(titleLabel)
        titleLabel <- [
            Height(80),
            CenterX(),
            Top()
        ]
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
//        scrollView <- Edges()
        scrollView <- [
            Width(*0.8).like(self),
            Top().to(titleLabel),
            Bottom().to(bottomView, .top),
            CenterX()
        ]
        
        stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        stackView <- Edges()
        stackView <- [
            Width().like(scrollView)
        ]
        
        layer.cornerRadius = 10
    }
    
    public func adjustToHeights(constraint : NSLayoutConstraint){
        if (scrollView != nil){
            scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
            let newHeight = stackView.frame.height + titleLabel.frame.height + bottomView.frame.height
            if (newHeight != 0 && constraint.constant != newHeight){
                UIView.animate(withDuration: 0.3, animations: { 
                    constraint.constant = newHeight
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    public func addElementsToStackedView() {
        let n = delegate.ttroPopView(numberOfViews: self)
        
        for i in 0..<n{
            stackView.addArrangedSubview(delegate.ttroPopView(numberOfViews: self, viewAtIndex: i))
        }
    }
}
