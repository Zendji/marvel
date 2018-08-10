//
//  MarvelDataRequest.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import Foundation


struct MarvelDataRequest {
    
    static var shared: MarvelDataRequest?
    
    var apikey: String?
    var privateKey: String?
    
    init(apikey: String, privateKey: String) {
        self.apikey = apikey
        self.privateKey = privateKey
    }
    
}
