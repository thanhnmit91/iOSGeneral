//
//  ViewController.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/16/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    
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
    }

    @IBAction func act(_ sender: Any) {
        abc = "456 - "
    }
    
}

