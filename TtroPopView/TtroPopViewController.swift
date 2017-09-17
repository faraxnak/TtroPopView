//
//  TtroPopViewController.swift
//  Pods
//
//  Created by Farid on 2/9/17.
//
//

import UIKit
import EasyPeasy
import PayWandBasicElements

@objc public protocol TtroPopViewControllerDelegate : TtroPopViewDelegate {
    @objc optional func popViewController(popViewTitle popViewController: TtroPopViewController) -> String
}

open class TtroPopViewController: UIViewController {

    var ttroPopView : TtroPopView!
    var popViewHeightConstraint : NSLayoutConstraint!
    
    public weak var delegate : TtroPopViewControllerDelegate!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        let blurView = APCustomBlurView(withRadius: 2)
        view.addSubview(blurView)
        blurView <- Edges()
        
        let title = delegate.popViewController?(popViewTitle: self) ?? "Currency Convertor"
        ttroPopView = TtroPopView(title: title, delegate : delegate)
        view.addSubview(ttroPopView)
        ttroPopView <- [
            Center(),
            Height(>=250).with(.high),
            Height(<=450).with(Priority.high),
            Width(*0.8).like(view)
        ]
        popViewHeightConstraint = ttroPopView.heightAnchor.constraint(equalToConstant: 300)
        popViewHeightConstraint.priority = 500
        popViewHeightConstraint.isActive = true
        ttroPopView.backgroundColor = UIColor.white
        ttroPopView.delegate = delegate
        ttroPopView.addElementsToStackedView()
        
        // Do any additional setup after loading the view.
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ttroPopView.adjustToHeights(constraint: popViewHeightConstraint)
    }

}
