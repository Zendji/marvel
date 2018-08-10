//
//  KeysUtils.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 09/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import Foundation

class KeysUtils {
    
    static var marvelApiKey: String? {
        get {
            if let value = getKey(key: "marvel_apikey"), value != "" {
                return value
            }
            return nil
        }
    }
    
    static var marvelPrivateKey: String? {
        get {
            if let value = getKey(key: "marvel_private key"), value != "" {
                return value
            }
            return nil
        }
    }
    
    private static func getKey(key: String) -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            if let value = dict[key] as? String {
                return value
            }
        }
        return nil
    }
    
}
