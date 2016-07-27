//
//  AddPlantViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = bgColorCode
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(saveItem(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveItem(sender: AnyObject) {
        let aPlant = Plant(maxWaterLevel: 20.0, type: "daisy", datePlanted: NSDate(), lastWatered: NSDate(), estHarvestDate: NSDate(), additionalInformation: "Information", vegetable: false)
        self.sendData(aPlant)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    var onDataAvailable : ((data: Plant) -> ())?

    func sendData(data: Plant) {
        // Whenever you want to send data back to viewController1, check
        // if the closure is implemented and then call it if it is
        self.onDataAvailable?(data: data)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
