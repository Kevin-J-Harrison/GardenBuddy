//
//  FirstViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
// WUG API Key: e46f36320707687d
//
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func setupView() {
        self.view.backgroundColor = bgColorCode
        self.titleLabel.backgroundColor = bgColorCode
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

