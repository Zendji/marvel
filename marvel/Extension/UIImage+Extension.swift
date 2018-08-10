//
//  UIImage+Extension.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import UIKit


extension UIImageView {
    
    public func shortImageFromUrl(urlString: String, extensionImage: String) {
        let url = "\(urlString)/portrait_small.\(extensionImage)"
        downloadImage(stringURL: url)
    }
    
    public func largeImageFromUrl(urlString: String, extensionImage: String) {
         let url = "\(urlString)/landscape_xlarge.\(extensionImage)"
        downloadImage(stringURL: url)
    }
    
    private func downloadImage(stringURL: String) {
        if let url = URL(string: stringURL) {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) -> Void in
                if let imageData = data as NSData? {
                    DispatchQueue.main.sync {
                        self.image = UIImage(data: imageData as Data)
                    }
                }
            }.resume()
        }
    }
}
