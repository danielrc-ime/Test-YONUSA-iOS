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
    //Arrays for Table
    var character: [String]?
    var quote: [String]?
    var image: [String]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpsonManager.delegate = self
        
        simpsonManager.fetchSimpson(numPeronajes: "10")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            simpsonManager.fetchSimpson(numPeronajes: "20")
        } else {
            simpsonManager.fetchSimpson(numPeronajes: "10")
        }
    }


}

extension SimpsonViewController: SimpsonManagerDelegate {
    func didUpdateSimpson(_ simpsonManager: SimpsonManager, simpson: [SimpsonModel]) {
        for item in simpson{
            character?.append(item.character)
            quote?.append(item.quote)
            image?.append(item.image)
            print(item.character)
        }
    }
    
    func didFailWitherror(error: Error) {
        print(error)
    }
    
    
}

