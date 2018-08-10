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

        if let apikey = MarvelDataRequest.shared?.apikey {
            let urlString = "https://gateway.marvel.com/v1/public/characters?"
            let dataLimit = "limit=\(limit)&offset=\(offset)&"
            let urlDataKey = "\(getFinalURL(apikey: apikey))"
            
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

    
    static func getFinalURL(apikey: String) -> String {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            let apikey = dict.index(forKey: "apikey")
            let privateKey = dict.index(forKey: "private key")
            
            print(apikey)
            print(privateKey)
        }
        
        let timestamp = self.currentTimeInMiliseconds()
        let privateKey = "2a54b9ac292aba7af08467200ce89c53ffac1625"
        let hash = "\(timestamp)\(privateKey)\(apikey)".md5()
        let finalUrl = "ts=\(timestamp)&apikey=6392fe4e33b318334c2a5b3f92e1fe4e&hash=\(hash)"
        return finalUrl
    }
    
    
}
