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
    
    var myGarden = [[Plant]]()
    var myVegetables = [Plant]()
    var myPlants = [Plant]()
    var ref : FIRDatabaseReference?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.tableView.backgroundColor = bgColorCode
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GardenViewController.longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        self.myGarden = [myVegetables, myPlants]
            
        self.ref = FIRDatabase.database().reference()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // read from this format yyyy-MM-dd HH:mm:ssZZ
        self.ref!.child("This-Device").observeEventType(.Value, withBlock: { snapshot in
            var myVegetables = [Plant]()
            var myPlants = [Plant]()
            if let postDict = snapshot.value as? [String : AnyObject] {
                for (key,val) in postDict.enumerate() {
                    let entry = Plant(snapshot: val.1 as! Dictionary<String,AnyObject>)
                    entry.setLastWatered()
                    if entry.vegetable == true {
                        myVegetables.append(entry)
                    }
                    else {
                        myPlants.append(entry)
                    }
                }
                self.myGarden = [myVegetables, myPlants]
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myGarden[section].count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.myGarden.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Vegetables"
        }
        else {
            return "Plants"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = self.myGarden[indexPath.section][indexPath.row].type
        cell.detailTextLabel!.text = "\(self.myGarden[indexPath.section][indexPath.row].daysSinceWatered())"
        cell.backgroundColor = self.myGarden[indexPath.section][indexPath.row].getCellColor()
        if self.myGarden[indexPath.section][indexPath.row].vegetable {
            cell.imageView?.image = UIImage(named: "veggie")
        }
        else {
            cell.imageView?.image = UIImage(named: "myGarden")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entry = self.myGarden[indexPath.section][indexPath.row]
            self.ref?.child("This-Device").child(entry.type).removeValue()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "plantDetail" {
            print("DETAIL ITEM")
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let viewController = segue.destinationViewController as? PlantDetailViewController {
                    viewController.onDataAvailable = {[weak self]
                        (data) in
                        if let weakSelf = self {
                            weakSelf.doSomethingWithData(data)
                        }
                    }
                    let object = myGarden[indexPath.section][indexPath.row]
                    print(object)
                    viewController.detailItem = object
                }
                
                
            }
        }
        else if segue.identifier == "addItem" {
                    //print("add me")
                    if let viewController = segue.destinationViewController as? AddPlantViewController {
                        viewController.onDataAvailable = {[weak self]
                            (data) in
                            if let weakSelf = self {
                                weakSelf.doSomethingWithData(data)
                            }
                        }
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
        if plant.vegetable == true {
            self.myGarden[0].append(plant)
        }
        else {
            self.myGarden[1].append(plant)
        }
        self.ref?.child("This-Device").child(plant.type).setValue(plant.toJSON())
        refreshView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        
        self.performSegueWithIdentifier("addItem", sender: self)
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                let plant = self.myGarden[indexPath.section][indexPath.row]
                plant.lastWatered = NSDate()
                self.ref?.child("This-Device").child(plant.type).setValue(plant.toJSON())
                refreshView()
            }
        }
    }
}

