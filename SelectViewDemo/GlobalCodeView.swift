//
//  GlobalCodeView.swift
//  KLAddressSelectorExample
//
//  Created by suhengxian on 2020/6/28.
//  Copyright © 2020 KL. All rights reserved.
//

import UIKit

@objc public protocol SelectedViewDelegate{
    @objc optional func selectedView(selectedViewString:String?)
}

class GlobalCodeView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.dataSource[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 35;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedStr = self.dataSource[row];
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var selectedStr:String?
    public weak var selectedStringDelegate:SelectedViewDelegate?
    
    var dataSource = [String](){
        didSet{
            //设置默认值
            self.pickerView.reloadAllComponents();
        }
    }
    
    lazy var pickerView:UIPickerView = {
        let pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y:kl_scaleHeight(h: 55), width: klScreen_width, height: kl_scaleHeight(h: 270)-kl_scaleHeight(h: 55)))
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.backgroundColor = UIColor.white
        return pickerView;
        
    }()
    
    lazy var contentView:UIView = {
        let containView = UIView.init(frame: CGRect.init(x: 0, y: klScreen_height-kl_scaleHeight(h: 270), width: klScreen_width, height: kl_scaleHeight(h: 270)))
        return containView
        
    }()
    
    lazy var titleToolBar:UIView = {
        let titleToolBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: klScreen_width, height: kl_scaleHeight(h: 55)))
        titleToolBar.backgroundColor = UIColor().hexStringToColor(hexString:"0xf6f6f6",alpha:1)
        
        return titleToolBar
        
    }()
    
    lazy var sureBtn:UIButton = {
        let sureBtn = UIButton.init(frame: CGRect.init(x: klScreen_width-kl_scaleWidth(w: 65), y: 0, width: kl_scaleWidth(w: 65), height:kl_scaleHeight(h: 55)))
        sureBtn.setTitle("确定", for: UIControl.State.normal)
        sureBtn.addTarget(self, action: #selector(addCodeBtnClick), for: UIControl.Event.touchUpInside)
        sureBtn.setTitleColor(UIColor().hexStringToColor(hexString: "0xff0000", alpha: 1.0), for: UIControl.State.normal)
        sureBtn.tag = 1;
        
        return sureBtn
    }()
    
    lazy var cancelButton:UIButton = {
        let cancleBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kl_scaleWidth(w: 65), height: kl_scaleHeight(h: 55)))
        cancleBtn.setTitle("取消", for: UIControl.State.normal)
        cancleBtn.addTarget(self, action: #selector(cancleClick), for: UIControl.Event.touchUpInside)
        cancleBtn.setTitleColor(UIColor().hexStringToColor(hexString: "0x666666", alpha: 1), for: UIControl.State.normal)
        
        return cancleBtn
    }()
    
    @objc private func addCodeBtnClick(){
        
        self.dismiss();
        if self.selectedStringDelegate != nil{
            self.selectedStringDelegate?.selectedView?(selectedViewString:self.selectedStr);
        }
    }
    
    @objc private func cancleClick(){
        self.dismiss();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commit() {
        self.frame = CGRect.init(x: 0, y: 0, width: klScreen_width, height: klScreen_height)
        
        addSubview(contentView)
        contentView.addSubview(titleToolBar)
        contentView.addSubview(pickerView)
        titleToolBar.addSubview(sureBtn)
        titleToolBar.addSubview(cancelButton)
        
    }
   
    func showView() {
        UIApplication.shared.keyWindow?.addSubview(self);
        self.backgroundColor = UIColor.clear;
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor().hexStringToColor(hexString:"0x000000", alpha:0.3)
        }
    }

    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.clear;
            
        }) { (finish) in
            self.removeFromSuperview();
            
        }
    }
    
}
