//
//  ViewController.swift
//  TicTacToe
//
//  Created by Yasmine Ghazy on 2/23/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func siglePlayerClicked(_ sender: Any) {
       let playMode = 1
        
       performSegue(withIdentifier: "toSinglePlayerGame", sender: playMode)
    }

    @IBAction func MultiplayerClicked(_ sender: Any) {
        let playMode = 2
         performSegue(withIdentifier: "toMultiPlayerGame", sender: playMode)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? GameVC {
            if let mode = sender as? Int{
               destination.playMode = mode
            }
            
            
        }
        
    }
    
    
    
}

