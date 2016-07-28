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
    
    //Max water level is the estimated days
    let maxDaysWithoutWater: Int
    let vegetable: Bool
    var type: String
    var datePlanted: NSDate
    var lastWatered: NSDate
    var estHarvestDate: NSDate
    var additionalInformation: String
    //var some picture
    var daysSinceWater: Int = 0
    
    init (maxDaysWithoutWater: Int, type: String, datePlanted: NSDate, lastWatered: NSDate, estHarvestDate: NSDate, additionalInformation: String, vegetable: Bool) {
        
        self.maxDaysWithoutWater = maxDaysWithoutWater
        self.type = type
        self.datePlanted = datePlanted
        self.lastWatered = lastWatered
        self.estHarvestDate = estHarvestDate
        self.additionalInformation = additionalInformation
        self.vegetable = vegetable
        setLastWatered()
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        
        //key = snapshot.key
        maxDaysWithoutWater = snapshot.value!["maxDaysWithoutWater"] as! Int
        type = snapshot.value!["type"] as! String
        datePlanted = NSDate(timeIntervalSinceReferenceDate: (snapshot.value!["datePlanted"] as! Double))
        lastWatered = NSDate(timeIntervalSinceReferenceDate: (snapshot.value!["lastWatered"] as! Double))
        estHarvestDate = NSDate(timeIntervalSinceReferenceDate: (snapshot.value!["lastWatered"] as! Double))
        additionalInformation = snapshot.value!["additionalInformation"] as! String
        vegetable = snapshot.value!["vegetable"] as! Bool
        daysSinceWater = snapshot.value!["daysSinceWater"] as! Int
        
        
    }
    
    init(snapshot: Dictionary<String,AnyObject>) {
        maxDaysWithoutWater = snapshot["maxDaysWithoutWater"] as! Int
        type = snapshot["type"] as! String
        datePlanted = NSDate(timeIntervalSinceReferenceDate: (snapshot["datePlanted"] as! Double))
        lastWatered = NSDate(timeIntervalSinceReferenceDate: (snapshot["lastWatered"] as! Double))
        estHarvestDate = NSDate(timeIntervalSinceReferenceDate: (snapshot["lastWatered"] as! Double))
        additionalInformation = snapshot["additionalInformation"] as! String
        vegetable = snapshot["vegetable"] as! Bool
        daysSinceWater = snapshot["daysSinceWater"] as! Int
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
    
    /*func calculateWaterLevel() {
        let rightNow = NSDate()
        //Current water level is the max water level minus the hours that have passed since last watering
        daysSinceWater = Int(maxWaterDays - (rightNow.timeIntervalSinceReferenceDate - datePlanted.timeIntervalSinceReferenceDate / (60*60)))
    }*/
    
    /*func addWater(waterAdded: Double) {
        //Add water
        daysSinceWater += waterAdded
        
        //If the water level is over max, set to max
        if daysSinceWater > maxWaterDays {
            daysSinceWater = maxWaterDays
        }
    }*/
    
    func daysSinceWatered() -> String {
        let calendar = NSCalendar.currentCalendar()
        let rightNow = NSDate()
        
        let componentsLastWatered = calendar.components([.Month, .Day], fromDate: self.lastWatered)
        let componentsNow = calendar.components([.Month, .Day], fromDate: rightNow)
        
        if componentsNow.day - componentsLastWatered.day  == 1{
            return "Last Watered: 1 day ago"
        }
        else if componentsNow.day >= componentsLastWatered.day {
            return "Last Watered: \(componentsNow.day - componentsLastWatered.day) days ago"
        }
        else {
            
            let hoursSince = Int((rightNow.timeIntervalSinceReferenceDate - datePlanted.timeIntervalSinceReferenceDate)
                / (60*60))
            var daysSince = hoursSince / 24
            if hoursSince % 24 > 14 {
                daysSince += 1
            }
            
            return "Last Watered: \(daysSince) days ago"
            
        }
    }
    
    func setLastWatered() {
        let calendar = NSCalendar.currentCalendar()
        let rightNow = NSDate()
        
        let componentsLastWatered = calendar.components([.Month, .Day], fromDate: self.lastWatered)
        let componentsNow = calendar.components([.Month, .Day], fromDate: rightNow)
        
        if componentsNow.day >= componentsLastWatered.day {
            self.daysSinceWater = componentsNow.day - componentsLastWatered.day
        }
        else {
            
            let hoursSince = Int((rightNow.timeIntervalSinceReferenceDate - datePlanted.timeIntervalSinceReferenceDate)
                / (60*60))
            var daysSince = hoursSince / 24
            if hoursSince % 24 > 14 {
                daysSince += 1
            }
            
            self.daysSinceWater = daysSince
        }
    }

    
    func getCellColor() -> UIColor {
        if maxDaysWithoutWater == daysSinceWater  {
            return colorYellow
        }
        else if maxDaysWithoutWater < daysSinceWater {
            return colorRed
        }
        else {
            return colorGreen
        }
    }
    
    func toJSON() -> Dictionary<String, AnyObject> {
        return ["maxDaysWithoutWater": maxDaysWithoutWater,
                "type": type,
                "datePlanted": datePlanted.timeIntervalSinceReferenceDate,
                "lastWatered": lastWatered.timeIntervalSinceReferenceDate,
                "estHarvestDate": estHarvestDate.timeIntervalSinceReferenceDate,
                "additionalInformation": additionalInformation,
                "vegetable": vegetable,
                "daysSinceWater": daysSinceWater]
    }
    
}
