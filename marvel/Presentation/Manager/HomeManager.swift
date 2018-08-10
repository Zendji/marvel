//
//  HomeManager.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import Foundation


protocol HomeDelegate: NSObjectProtocol {
    func sucess(heros: [Result])
    func error()
}

class HomeManager {
    
    
    private var delegate: HomeDelegate?
    
    private var limit = 20
    private var offset = 0
    
    init(delegate: HomeDelegate) {
        self.delegate = delegate
    }
    
    func getHeroes() {
        MarvelProvider.requestAllHeroes(limit: self.limit, offset: self.offset, requestSucess: {
            (success, offset, result) in
            DispatchQueue.main.async {
                if success {
                    self.offset = offset + self.limit
                    self.delegate?.sucess(heros: result!)
                    return
                }
                self.delegate?.error()
            }
        })
    }
    
}
