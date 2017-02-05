//
//  TtroPopView.swift
//  TtroPopView
//
//  Created by Farid on 2/5/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import EasyPeasy

public protocol TtroPopViewDelegate : BottomViewDelegate {
    
}

public class TtroPopView: UIView {
    
    
    var stackView : UIStackView!
    var scrollView : UIScrollView!
    
    func initElements() {
        
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView <- Edges()
        
        stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        stackView <- Edges()
        stackView <- [
            Width().like(self)
        ]
        
        
        let bottomView = BottomView(numberOfButtons: 3)
        self.addSubview(bottomView)
        bottomView <- [
            Height(50),
            Bottom(),
            Width(*0.9).like(self),
            CenterX()
        ]
    }
}
