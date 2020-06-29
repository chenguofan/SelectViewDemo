//
//  ViewController.swift
//  SelectViewDemo
//
//  Created by suhengxian on 2020/6/29.
//  Copyright © 2020 suhengxian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init()
        btn.frame = CGRect.init(x: 100, y:100, width:100, height: 100)
        btn.backgroundColor = UIColor.red;
        btn.addTarget(self, action: #selector(btnClick), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(btn)
        
    }
    @objc func btnClick(){
        NSLog("chi fan le ma");
        
        let globalCodeView = GlobalCodeView.init()
        globalCodeView.dataSource = ["1","2","3","4","5","6"];
        globalCodeView.showView()
        globalCodeView.selectedStringDelegate = self;
        
    }

}

extension ViewController:SelectedViewDelegate{
    func selectedView(selectedViewString: String?) {
        NSLog("selectedViewString:\(selectedViewString)");
    }
}

