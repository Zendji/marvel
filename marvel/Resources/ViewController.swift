//
//  ViewController.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelInfo: UILabel!
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        verifyKeys()
    }
    
    func verifyKeys() {
        if KeysUtils.marvelApiKey == nil || KeysUtils.marvelPrivateKey == nil {
            labelInfo.text = "Por favor adicione as chaves no arquivo info.plist"
            buttonContinue.isEnabled = false
            return
        }
        buttonContinue.isEnabled = true
        labelInfo.text = "Chaves adicionadas! clique em continuar"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func insertApikeyAction(_ sender: Any) {
        gotoHome()
    }
    
    func gotoHome() {
        guard let apikey = KeysUtils.marvelApiKey, let privateKey = KeysUtils.marvelPrivateKey else {
            labelInfo.text = "Por favor adicione as chaves no arquivo info.plist"
            buttonContinue.isEnabled = false
            return
        }
        
        MarvelDataRequest.shared =  MarvelDataRequest(apikey: apikey, privateKey: privateKey)
        performSegue(withIdentifier: "segueHome", sender: nil)
    }
    
}

