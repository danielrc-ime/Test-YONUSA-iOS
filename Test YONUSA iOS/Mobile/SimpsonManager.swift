//
//  SimpsonManager.swift
//  Test YONUSA iOS
//
//  Created by MacInnovacion on 11/09/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

protocol SimpsonManagerDelegate {
    func didUpdateSimpson(_ simpsonManager: SimpsonManager, simpson: [SimpsonModel])
    func didFailWitherror(error: Error)
}

struct SimpsonManager {
    let simpsonURL = "https://thesimpsonsquoteapi.glitch.me/quotes?count="
    
    var delegate: SimpsonManagerDelegate?
    
    func fetchSimpson(numPeronajes: String){
        let urlString = "\(simpsonURL)\(numPeronajes)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        //First Create URL
        if let url = URL(string: urlString){
            //Second URLSession
            let session = URLSession(configuration: .default)
            //Third Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //print(error!)
                    self.delegate?.didFailWitherror(error: error!)
                    return
                }
                if let safeData = data {
                    //print(String(data: safeData, encoding: .utf8)!)
                    if let simpsonData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateSimpson(self, simpson: simpsonData)
                    }
                }
            }
            //Fourth Start the Task
            task.resume()
        }
    }

    private func parseJSON(_ simpsonData: Data) -> [SimpsonModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([SimpsonData].self, from: simpsonData)
            //print(decodedData.count)
            var search: [SimpsonModel] = []
            
            for item in decodedData {
                search.append(SimpsonModel(quote: item.quote, character: item.character, image: item.image))
                //print(item.character)
            }
            return search
        } catch {
            //print(error)
            delegate?.didFailWitherror(error: error)
            return nil
        }
    }
    
}

