//
//  ViewController.swift
//  Test YONUSA iOS
//
//  Created by MacInnovacion on 11/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class SimpsonViewController: UIViewController {
    
    var simpsonManager = SimpsonManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        simpsonManager.fetchSimpson(numPeronajes: "2")
    }


}

