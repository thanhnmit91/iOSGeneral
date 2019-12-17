//
//  ViewController.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var viewTabbar: ViewContainTabbar!
    let vc1 = ViewController1()
    let vc2 = ViewController2()
    var abc: String? {
        didSet{
            lb1.text = (abc ?? "") + "123"
            print(lb1.text ?? "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(#column)")
//        self.addVCDefaults()
        viewTabbar.selectItemTabbar = { [weak self] (item) in
            switch item {
            case 1:
                self?.vc2.view.backgroundColor = UIColor.yellow
                self?.vc2.view.tag = 2
                self?.addVCView(self!.vc2)
                break
            default:
                self?.vc1.view.backgroundColor = UIColor.red
                self?.vc1.view.tag = 1
                self?.addVCView(self!.vc1)
                break
            }
        }
        
        print("Keychain Device: \(KeychainManager.sharedInstance.getDeviceIdentifierFromKeychain())")
    }
    
    func addVCDefaults(){
        self.vc1.view.backgroundColor = UIColor.red
        self.vc1.view.tag = 1
        self.addVCView(self.vc1)
    }
    
    func addVCView( _ vc: UIViewController){
        for itemVc in self.view.subviews {
            itemVc.isHidden = itemVc.tag != 0
            if itemVc.tag == vc.view.tag {
                itemVc.isHidden = false
            }
        }
        if self.view.subviews.contains(vc.view){
            return
        }
        print("Add 1 times \(vc.view.tag)")
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64)
        self.displayContentController(content: vc)
    }

    @IBAction func act(_ sender: Any) {
        abc = "456 - "
    }
    
}

