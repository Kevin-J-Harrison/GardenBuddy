//
//  DetailViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var plantTypeLabel: UILabel!
    @IBOutlet weak var datePlantedLabel: UILabel!
    @IBOutlet weak var lastWateredLabel: UILabel!
    @IBOutlet weak var estimatedHarvestLabel: UILabel!
    @IBOutlet weak var plantInfoField: UITextView!
    
    var detailItem : Plant?
    
    lazy var formatter: NSDateFormatter = {
        var tmpFormatter = NSDateFormatter()
        tmpFormatter.dateFormat = "MM/dd/yyyy"
        return tmpFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PlantDetailViewController.tapFunction(_:)))
        self.lastWateredLabel.userInteractionEnabled = true
        self.lastWateredLabel.addGestureRecognizer(tap)
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.view.backgroundColor = bgColorCode
        self.plantTypeLabel.text = detailItem!.type
        self.datePlantedLabel.text = "Date Planted: " + formatter.stringFromDate(detailItem!.datePlanted)
        self.lastWateredLabel.text = "Last Watered: " + formatter.stringFromDate(detailItem!.lastWatered)
        self.estimatedHarvestLabel.text = "Estimated Harvest"
        
    }

    /*
    // MARK: - Navigation
    */
    
    func cancel(sender: AnyObject) {
        print("CANCEL")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
    }
    
    var onDataAvailable : ((data: Plant) -> ())?
    
    func sendData(data: Plant) {
        // Whenever you want to send data back to viewController1, check
        // if the closure is implemented and then call it if it is
        self.onDataAvailable?(data: data)
    }

}
