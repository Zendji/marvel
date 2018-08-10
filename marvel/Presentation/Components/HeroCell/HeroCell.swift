//
//  HeroCell.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import UIKit

class HeroCell: UITableViewCell {
    
    @IBOutlet weak var heroImage: UIImageView?
    
    @IBOutlet weak var heroName: UILabel?
    @IBOutlet weak var heroDescription: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(heroName: String, descriptipn: String, urlImage: Thumbnail) {
        self.heroName?.text = heroName
        self.heroDescription?.text = descriptipn
        
        self.heroImage?.shortImageFromUrl(urlString: urlImage.path, extensionImage: urlImage.imageExtension)
    }
    
    
}
