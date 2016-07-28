//
//  SecondViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GardenViewController: UITableViewController {
    
    var myGarden = [Plant]()
    var ref : FIRDatabaseReference?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
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
        
        self.ref = FIRDatabase.database().reference()
        
        /*if let data = NSUserDefaults.standardUserDefaults().objectForKey("myGarden") as? NSData {
             let datas = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Plant]
            print(datas)
        }
        
        if let books = NSKeyedUnarchiver.unarchiveObjectWithFile("/myGarden") as? [Plant] {
            print(books.count)
        }*/
        /*if let names = NSKeyedUnarchiver.unarchiveObjectWithFile(filename) as? [String] {
            myGarden = names
        }*/
        //let item = "hi"
        //self.ref?.child("my-groceries").child("no").setValue(myGarden[0].toJSON())
        
        self.ref?.child(deviceID).setValue(myGarden[0].toJSON())
        
        
    }
    
    /*override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        // read from this format yyyy-MM-dd HH:mm:ssZZ
        self.ref!.child("my-groceries").observeEventType(.Value, withBlock: { snapshot in
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZ"
            dateStringFormatter.timeZone = NSTimeZone(name: "UTC")
            var newEntries = [Plant]()
            if let postDict = snapshot.value as? [String : AnyObject] {
                for (key,val) in postDict.enumerate() {
                    print("key = \(key) and val = \(val)")
                    let entry = Plant(snapshot: val.1 as! Dictionary<String,AnyObject>)
                    newEntries.append(entry)
                }
                self.objects = newEntries
                //self.objects.sortInPlace({ $0.compare($1) == NSComparisonResult.OrderedDescending })
                self.tableView.reloadData()
            }
        })
    }*/
    
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
            /*if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PlantDetailViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }*/
        }
        else if segue.identifier == "addItem" {
                    print("add me")
                    if let viewController = segue.destinationViewController as? AddPlantViewController {
                        viewController.onDataAvailable = {[weak self]
                            (data) in
                            if let weakSelf = self {
                                weakSelf.doSomethingWithData(data)
                            }
                        }
                    
//                    let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PlantDetailViewController
//                    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
        }

        
    }
    
    func refreshView() {
        self.tableView.reloadData()
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func doSomethingWithData(plant: Plant) {
        myGarden.append(plant)
        //NSKeyedArchiver.archiveRootObject(myGarden, toFile: "/myGarden")
        /*let filename = getDocumentsDirectory().stringByAppendingPathComponent("/hi")q
        let data = NSKeyedArchiver.archivedDataWithRootObject(myGarden)
        
        
        data.writeToFile(filename, atomically: true)
        //NSUserDefaults.standardUserDefaults().setObject(data, forKey: "myGarden")*/
        refreshView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        
        self.performSegueWithIdentifier("addItem", sender: self)
    }
}

