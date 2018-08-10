//
//  DetailViewController.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import UIKit
import Hero

class DetailViewController: UIViewController {
    
    var heroSelected: Result?
    
    @IBOutlet weak var heroName: UILabel?
    @IBOutlet weak var heroImage: UIImageView?
    @IBOutlet weak var labelHeroDescription: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup() {
        heroName?.text = self.heroSelected?.name
        labelHeroDescription?.text = self.heroSelected?.description
        
        if let thumbnail = self.heroSelected?.thumbnail {
            self.heroImage?.largeImageFromUrl(urlString: thumbnail.path, extensionImage: thumbnail.imageExtension)
        }

    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
