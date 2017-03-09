//
//  ViewController.swift
//  TtroPopViewSample
//
//  Created by Farid on 2/5/17.
//  Copyright © 2017 ParsPay. All rights reserved.
//

import UIKit
import TtroPopView
import EasyPeasy
import PayWandBasicElements

public protocol ConverterPopViewControllerDelegate : UIPickerViewDataSource, UIPickerViewDelegate {
    
}

class ConverterPopViewController: UIViewController {

    var ttroPopView : TtroPopView!
    var popViewHeightConstraint : NSLayoutConstraint!
    //
    var currencyPicker = UIPickerView()
    var changeCurrencyButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerDelegate = CurrencyPickerDelegate(pickerRowSelected: {(symbol, index) in
            print(symbol, index)
        })
        currencyPicker.delegate = pickerDelegate
        currencyPicker.dataSource = pickerDelegate
        
        ttroPopView = TtroPopView(title: "Currency Convertor", delegate : self)
        view.addSubview(ttroPopView)
        ttroPopView <- [
            Center(),
            Height(>=250).with(.highPriority),
            Height(<=450).with(Priority.highPriority),
            Width(*0.8).like(view)
        ]
        popViewHeightConstraint = ttroPopView.heightAnchor.constraint(equalToConstant: 300)
        popViewHeightConstraint.priority = 500
        popViewHeightConstraint.isActive = true
        ttroPopView.backgroundColor = UIColor.white
        ttroPopView.addElementsToStackedView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ttroPopView.adjustToHeights(constraint: popViewHeightConstraint)
    }
}

extension ConverterPopViewController : TtroPopViewDelegate {
    func ttroPopView(numberOfViews popView : TtroPopView) -> Int {
        return 4
    }
    
    func ttroPopView(numberOfViews popView : TtroPopView, viewAtIndex index : Int) -> UIView {
        switch index {
        case 0:
//            let v = UIView() //BackgroundAttributeView
//            let c = HiglightTextView()
//            c.text = NSAttributedString(string: "this is highlighted text, this is highlighted text, this is highlighted text", attributes: [NSFontAttributeName : UIFont.TtroPayWandFonts.regular1.font, HiglightTextView.HighLightColorAttribute : UIColor.TtroColors.orange.color, NSForegroundColorAttributeName : UIColor.white])
//            v.addSubview(c)
//            c <- Edges()
//            c <- Height(100)
//            return v
            return getAmountView()
        case 1:
            return getExchangeCurrencyView()
        case 2:
            //currencyPicker.isHidden = true
            currencyPicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
            return currencyPicker
        case 3:
            let exchangedAmountLabel = TtroLabel(font: UIFont.TtroPayWandFonts.regular2.font, color: UIColor.TtroColors.darkBlue.color)
            exchangedAmountLabel.text = "77.2 $"
            exchangedAmountLabel.textAlignment = .center
            exchangedAmountLabel <- Height(50)
            //exchangedAmountLabel <- Height(*0.25).like(ttroPopView)
            return exchangedAmountLabel
        default:
            fatalError("index exceeds maximium number of views")
        }
    }
    
    func getAmountView() -> UIView {
        let amountView = UIView()
        
        let sourceCurrencyLabel = TtroLabel(font: UIFont.TtroPayWandFonts.light2.font, color: UIColor.TtroColors.darkBlue.color)
        sourceCurrencyLabel.text = "IRR(Iran)"
        amountView.addSubview(sourceCurrencyLabel)
        sourceCurrencyLabel <- [
            Left(),
            CenterY(),
            Top(10),
            Bottom(10)
        ]
        
        let sourceAmountTextField = TtroTextField(placeholder: "Enter amount", font: UIFont.TtroPayWandFonts.light2.font)
        sourceAmountTextField.textColor = UIColor.TtroColors.darkBlue.color
        sourceAmountTextField.backgroundColor = UIColor.TtroColors.white.color
        amountView.addSubview(sourceAmountTextField)
        sourceAmountTextField <- [
            Right().to(amountView, .right),
            CenterY()
        ]
        sourceAmountTextField.text = "25000"
        
        let currencySymbolLabel = TtroLabel(font: UIFont.TtroPayWandFonts.light2.font, color: UIColor.TtroColors.darkBlue.color)
        currencySymbolLabel.text = "¢"
        currencySymbolLabel.textAlignment = .center
        currencySymbolLabel <- Width(20)
        sourceAmountTextField.rightView = currencySymbolLabel
        sourceAmountTextField.rightViewMode = .always
        return amountView
    }
    
    func getExchangeCurrencyView() -> UIView {
        let view = UIView()
        view <- Height(50)
        //view.layer.borderColor = UIColor.TtroColors.darkBlue.color.withAlphaComponent(0.3).cgColor
        //view.layer.borderWidth = 1
        let exchangeCurrencyLabel = TtroLabel(font: UIFont.TtroPayWandFonts.light2.font, color: UIColor.TtroColors.darkBlue.color)
        exchangeCurrencyLabel.text = "USD (United States)"
        view.addSubview(exchangeCurrencyLabel)
        exchangeCurrencyLabel <- [
            Left(),
            CenterY()
        ]
        changeCurrencyButton = UIButton(type: .system)
        changeCurrencyButton.setTitle("…", for: .normal)
        changeCurrencyButton.setTitle("x", for: .selected)
        changeCurrencyButton.setTitleColor(UIColor.TtroColors.darkBlue.color, for: .normal)
        changeCurrencyButton.titleLabel?.font = UIFont.TtroPayWandFonts.regular2.font
        changeCurrencyButton.addTarget(self, action: #selector(self.onChangeCurrency), for: .touchUpInside)
        
        view.addSubview(changeCurrencyButton)
        changeCurrencyButton <- [
            Right(),
            CenterY(),
        ]
        return view
    }
    
    func onChangeCurrency() {
        if (currencyPicker.isHidden){
            changeCurrencyButton.isSelected = true
            currencyPicker.isHidden = false
            currencyPicker.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.currencyPicker.alpha = 1
            })
        } else {
            changeCurrencyButton.isSelected = false
            currencyPicker.isHidden = true
        }
        
        ttroPopView.layoutIfNeeded()
    }
    
    public func bottomView(numberOfButtons bottomView : BottomView) -> Int {
        return 3
    }
    
    public func bottomView(listOfButtonTitles bottomView : BottomView, numberOfButtons n : Int) -> [String] {
        return ["Ok", "Converter", "Page"]
    }
    
    public func onSecondButton(){
        print("2")
    }
    
    public func onFirstButton(){
        print("1")
    }
    
    public func onThirdButton(){
        print("3")
    }
}

class CurrencyPickerDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var currencyList = [String]()
    var currencySymbols = [String]()
    
    typealias PickerRowSelected = (_ selectedItem : String, _ row : Int) -> ()
    var pickerRowSelected : PickerRowSelected?
    
    var pickerRowSelectedCurrencyTitle : PickerRowSelected?
    
    init(pickerRowSelected: PickerRowSelected?, pickerRowSelectedCurrencyTitle: PickerRowSelected? = nil) {
        super.init()
        self.pickerRowSelected = pickerRowSelected
        self.pickerRowSelectedCurrencyTitle = pickerRowSelectedCurrencyTitle
        initPickerSource()
    }
    
    fileprivate func initPickerSource(){
        currencyList = ["IRR", "USD", "EUR"]
        currencySymbols = ["£", "$", "€"]
    }
    
//    func setPickerSource(_ exchangeModels : [ExchangeModel]){
//        currencyList.removeAll()
//        currencySymbols.removeAll()
//        for model in exchangeModels {
//            currencyList.append(AppData.sharedInstance.currencyDetailList[model.destinationCurrencyIdFK!])
//            currencySymbols.append(AppData.sharedInstance.currencySimbolList[model.destinationCurrencyIdFK!])
//        }
//    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    
    //    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    //        return currencyList[row]
    //    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerRowSelected?(currencySymbols[row], row)
        pickerRowSelectedCurrencyTitle?(currencyList[row], row)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?{
        return NSAttributedString(string: currencyList[row], attributes: [NSForegroundColorAttributeName : UIColor.TtroColors.white.color])
    }
}

