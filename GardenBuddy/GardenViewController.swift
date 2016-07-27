//
//  SecondViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit

class GardenViewController: UITableViewController {
    
    var myGarden = [Plant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.tableView.backgroundColor = bgColorCode
        
        //let plant = Plant(maxWaterLevel: 20.0, type: "daisy", datePlanted: NSDate(), lastWatered: NSDate(), estHarvestDate: NSDate(), additionalInformation: "Information", vegetable: false)
        
        myGarden.append(Plant(maxWaterLevel: 20.0, type: "daisy", datePlanted: NSDate(), lastWatered: NSDate(), estHarvestDate: NSDate(), additionalInformation: "Information", vegetable: false))
        myGarden.append(Plant(maxWaterLevel: 20.0, type: "daisy", datePlanted: NSDate(), lastWatered: NSDate(), estHarvestDate: NSDate(), additionalInformation: "Information", vegetable: false)
)
        myGarden.append(Plant(maxWaterLevel: 20.0, type: "daisy", datePlanted: NSDate(), lastWatered: NSDate(), estHarvestDate: NSDate(), additionalInformation: "Information", vegetable: false)
)
        myGarden[1].currentWaterLevel = 25
        myGarden[2].currentWaterLevel = 0
        
        
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGarden.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel!.text = myGarden[indexPath.row].type
        cell.detailTextLabel!.text = "\(myGarden[indexPath.row].daysSinceWater())"
        cell.backgroundColor = myGarden[indexPath.row].getCellColor()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "plantDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PlantDetailViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        /*else if segue.identifier == "addItem" {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    
                    let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PlantDetailViewController
                    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
        }*/

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        
        self.performSegueWithIdentifier("addItem", sender: self)
    }
}

