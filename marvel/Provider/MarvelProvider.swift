//
//  MarvelProvider.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import Foundation
import CryptoSwift

struct MarvelProvider {
    
    public static func requestAllHeroes(limit: Int, offset:Int, requestSucess: @escaping requestSucess) {

        if let apikey = MarvelDataRequest.shared?.apikey, let privateKey = MarvelDataRequest.shared?.privateKey {
            let urlString = "https://gateway.marvel.com/v1/public/characters?"
            let dataLimit = "limit=\(limit)&offset=\(offset)&"
            let urlDataKey = "\(getFinalURL(apikey: apikey, privateKey: privateKey))"
            
            let urlComplete = urlString + dataLimit + urlDataKey
            
            let url = URL(string: urlComplete)
            
            let session = URLSession.shared
            
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    return
                }
                let responseMarvel = try? JSONDecoder().decode(Response.self, from: data!)
                
                if responseMarvel?.code == 200 {
                    requestSucess(true, (responseMarvel?.data.offset)! ,responseMarvel?.data.results)
                    return
                }
                requestSucess(false, 0, nil)
                
            }
            task.resume()
        }
    }
    
    
    static func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }

    
    static func getFinalURL(apikey: String, privateKey: String) -> String {
        
        let timestamp = self.currentTimeInMiliseconds()
        let privateKey = privateKey
        let hash = "\(timestamp)\(privateKey)\(apikey)".md5()
        let finalUrl = "ts=\(timestamp)&apikey=\(apikey)&hash=\(hash)"
        return finalUrl
    }
    
    
}
