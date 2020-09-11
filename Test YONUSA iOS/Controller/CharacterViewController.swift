//
//  CharacterViewController.swift
//  Test YONUSA iOS
//
//  Created by MacInnovacion on 11/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var characterLabel: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBAction func BackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var characterString: String!
    var quoteString: String!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterLabel.text = characterString
        quoteLabel.text = quoteString
        imageView.image = image
    }
    
}
