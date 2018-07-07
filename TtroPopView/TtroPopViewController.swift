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
    
    @objc optional func popViewController(viewDidApper animated: Bool)
}

//public enum TtroPopMode {
//    case light, dark
//}

open class TtroPopViewController: UIViewController {
    
//    open var mode : TtroPopMode = .light

    var ttroPopView : TtroPopView!
    var popViewHeightConstraint : NSLayoutConstraint!
    
    public weak var delegate : TtroPopViewControllerDelegate!
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate.popViewController?(viewDidApper: animated)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        let blurView = APCustomBlurView(withRadius: 2)
        view.addSubview(blurView)
        blurView.easy.layout(Edges())
        
//        if mode == .dark {
//            blurView.backgroundColor = UIColor.TtroColors.darkBlue.color.withAlphaComponent(0.4)
//        }
        
        let title = delegate.popViewController?(popViewTitle: self) ?? "Currency Convertor"
        ttroPopView = TtroPopView(title: title, delegate : delegate)
        view.addSubview(ttroPopView)
        ttroPopView.easy.layout([
            Center(),
            Height(>=250),
            Height(<=450),
            Width(*0.8).like(view)
        ])
        popViewHeightConstraint = ttroPopView.heightAnchor.constraint(equalToConstant: 300)
        popViewHeightConstraint.priority = UILayoutPriority(rawValue: 500)
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
