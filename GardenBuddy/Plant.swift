//
//  Plant.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import UIKit

class Plant {
    
    //Max water level is the estimated hours the plant can go without receiving water
    let maxWaterLevel: Double
    let vegetable: Bool
    var type: String
    var datePlanted: NSDate
    var lastWatered: NSDate
    var estHarvestDate: NSDate
    var additionalInformation: String
    //var some picture
    var currentWaterLevel: Double = 30.0
    let hello = "bye"
    
    init (maxWaterLevel: Double, type: String, datePlanted: NSDate, lastWatered: NSDate, estHarvestDate: NSDate, additionalInformation: String, vegetable: Bool) {
        
        self.maxWaterLevel = maxWaterLevel
        self.type = type
        self.datePlanted = datePlanted
        self.lastWatered = lastWatered
        self.estHarvestDate = estHarvestDate
        self.additionalInformation = additionalInformation
        self.vegetable = vegetable
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        
        //key = snapshot.key
        maxWaterLevel = snapshot.value!["maxWaterLevel"] as! Double
        type = snapshot.value!["type"] as! String
        datePlanted = NSDate(timeIntervalSinceReferenceDate: (snapshot.value!["datePlanted"] as! Double))
        lastWatered = NSDate(timeIntervalSinceReferenceDate: (snapshot.value!["lastWatered"] as! Double))
        estHarvestDate = NSDate(timeIntervalSinceReferenceDate: (snapshot.value!["lastWatered"] as! Double))
        additionalInformation = snapshot.value!["additionalInformation"] as! String
        vegetable = snapshot.value!["vegetable"] as! Bool
        currentWaterLevel = snapshot.value!["currentWaterLevel"] as! Double
        
        
    }
    
    init(snapshot: Dictionary<String,AnyObject>) {
        maxWaterLevel = snapshot["maxWaterLevel"] as! Double
        type = snapshot["type"] as! String
        datePlanted = NSDate(timeIntervalSinceReferenceDate: (snapshot["datePlanted"] as! Double))
        lastWatered = NSDate(timeIntervalSinceReferenceDate: (snapshot["lastWatered"] as! Double))
        estHarvestDate = NSDate(timeIntervalSinceReferenceDate: (snapshot["lastWatered"] as! Double))
        additionalInformation = snapshot["additionalInformation"] as! String
        vegetable = snapshot["vegetable"] as! Bool
        currentWaterLevel = snapshot["currentWaterLevel"] as! Double
    }
    
//    // MARK: NSCoding
//    
//    required convenience init?(coder decoder: NSCoder) {
//        guard let type = decoder.decodeObjectForKey("type") as? String,
//            let datePlanted = decoder.decodeObjectForKey("datePlanted") as? NSDate,
//            let lastWatered = decoder.decodeObjectForKey("lastWatered") as? NSDate,
//            let estHarvestDate = decoder.decodeObjectForKey("estHarvestDate") as? NSDate,
//            let additionalInformation = decoder.decodeObjectForKey("additionalInformation") as? String
//            else { return nil }
//        
//        self.init(
//            maxWaterLevel: decoder.decodeDoubleForKey("maxWaterLevel"),
//            type: type,
//            datePlanted: datePlanted,
//            lastWatered: lastWatered,
//            estHarvestDate: estHarvestDate,
//            additionalInformation: additionalInformation,
//            vegetable: decoder.decodeBoolForKey("vegetable")
//        )
//    }
//    
//    func encodeWithCoder(coder: NSCoder) {
//        coder.encodeDouble(self.maxWaterLevel, forKey: "maxWaterLevel")
//        coder.encodeObject(self.type, forKey: "type")
//        coder.encodeObject(self.datePlanted, forKey: "datePlanted")
//        coder.encodeObject(self.lastWatered, forKey: "lastWatered")
//        coder.encodeObject(self.estHarvestDate, forKey: "estHarvestDate")
//        coder.encodeBool(self.vegetable, forKey: "vegetable")
//    }
    
    func calculateWaterLevel() {
        let rightNow = NSDate()
        //Current water level is the max water level minus the hours that have passed since last watering
        currentWaterLevel = maxWaterLevel - (rightNow.timeIntervalSinceReferenceDate - datePlanted.timeIntervalSinceReferenceDate / (60*60))
    }
    
    func addWater(waterAdded: Double) {
        //Add water
        currentWaterLevel += waterAdded
        
        //If the water level is over max, set to max
        if currentWaterLevel > maxWaterLevel {
            currentWaterLevel = maxWaterLevel
        }
    }
    
    func daysSinceWater() -> String {
        let rightNow = NSDate()
        
        let daysSince = ((rightNow.timeIntervalSinceReferenceDate - datePlanted.timeIntervalSinceReferenceDate)
            / (60*60*24) )
        
        if Int(daysSince) == 1 {
            return "Last Watered: 1 day ago"
        }
        else {
            return "Last Watered: \(Int(daysSince)) days ago"
        }
    }
    
    func getCellColor() -> UIColor {
        if currentWaterLevel < 10 {
            return colorRed
        }
        else if currentWaterLevel < 30 {
            return colorYellow
        }
        else {
            return colorGreen
        }
    }
    
    func toJSON() -> Dictionary<String, AnyObject> {
        return ["maxWaterLevel": maxWaterLevel,
                "type": type,
                "datePlanted": datePlanted.timeIntervalSinceReferenceDate,
                "lastWatered": lastWatered.timeIntervalSinceReferenceDate,
                "estHarvestDate": estHarvestDate.timeIntervalSinceReferenceDate,
                "additionalInformation": additionalInformation,
                "vegetable": vegetable,
                "currentWaterLevel": currentWaterLevel]
    }
    
}
