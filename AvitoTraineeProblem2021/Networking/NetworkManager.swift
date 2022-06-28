//
//  NetworkManager.swift
//  AvitoTraineeProblem2021
//
//  Created by Fed on 27.06.2022.
//

import Foundation

protocol NetworkDelegate {
    func loadData(dataResultsLoaded: NetworkData)
    func errorWarning(with: Error)
}

struct NetworkManager {
    
    var delegate: NetworkDelegate?
    
    let urlStr = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    func fetchData()  {
        if let url = URL(string: urlStr) {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForResource = 60
            config.waitsForConnectivity = true
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(NetworkData.self, from: safeData)
                            self.delegate?.loadData(dataResultsLoaded: results)
                        } catch {
                            self.delegate?.errorWarning(with: error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
}


