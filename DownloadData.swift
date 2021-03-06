//
//  DownloadData.swift
//  covidWatchApp WatchKit Extension
//
//  Created by Eduardo Lombardi on 13/05/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import Foundation


class DownloadData: ObservableObject {
    
    @Published var globalData:Global? = nil
    @Published var date = Date()
    @Published var error:String = ""
    
    init() {
        downloadData(completion: { result in
            DispatchQueue.main.async {
                self.globalData = result?.global
            }
        })
        
    }
    
    func downloadData(completion: @escaping (Covid?) -> ()) {
        guard let jsonUrl = URL(string: "https://api.covid19api.com/summary") else { return }

        URLSession.shared.dataTask(with: jsonUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let covidData = try decoder.decode(Covid.self, from: data)
                completion(covidData)
            } catch let err {
               // self.erro = "Ops, aconteceu um erro."
                completion(nil)
                print("Err", err)
            }
            }.resume()
    }
}
