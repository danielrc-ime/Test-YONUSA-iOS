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
    var character: [String] = []
    var quote: [String] = []
    var image: [String] = []
    //tableCell
    var index = 0
    var imageToView: UIImage!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpsonManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        simpsonManager.fetchSimpson(numPeronajes: "10")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            simpsonManager.fetchSimpson(numPeronajes: "20")
        } else {
            simpsonManager.fetchSimpson(numPeronajes: "10")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterSegue" {
            let destinationVC = segue.destination as! CharacterViewController
            destinationVC.characterString = character[index]
            destinationVC.quoteString = quote[index]
            destinationVC.image = imageToView
        }
    }
}

//MARK: - TableViewDelegata and DataSource
extension SimpsonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text  = character[indexPath.row]
        cell.imageView!.imageFromServerURL(urlString: image[indexPath.row], PlaceHolderImage: UIImage(systemName: "xmark.icloud")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.item
        let currentCell = tableView.cellForRow(at: indexPath)
        imageToView = currentCell?.imageView!.image
        //print(index)
        self.performSegue(withIdentifier: "showCharacterSegue", sender: self)
    }
}

//MARK: - SimpsonManagerDelegate
extension SimpsonViewController: SimpsonManagerDelegate {
    func didUpdateSimpson(_ simpsonManager: SimpsonManager, simpson: [SimpsonModel]) {
        //Clear Arrays
        character = []; quote = []; image = []
        DispatchQueue.main.async {
            for item in simpson{
                self.character.append(item.character)
                self.quote.append(item.quote)
                self.image.append(item.image)
                print(item.character)
            }
            self.tableView.reloadData()
        }
    }
    
    func didFailWitherror(error: Error) {
        print(error)
    }
}

//MARK: - UIImageView Load fromURL
extension UIImageView {

public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

       if self.image == nil{
             self.image = PlaceHolderImage
       }

       URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

           if error != nil {
               print(error ?? "No Error")
               return
           }
           DispatchQueue.main.async(execute: { () -> Void in
               let image = UIImage(data: data!)
               self.image = image
           })

       }).resume()
   }}

