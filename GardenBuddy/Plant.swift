//
//  Plant.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import Foundation

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
    
    init (maxWaterLevel: Double, type: String, datePlanted: NSDate, lastWatered: NSDate, estHarvestDate: NSDate, additionalInformation: String, vegetable: Bool) {
        
        self.maxWaterLevel = maxWaterLevel
        self.type = type
        self.datePlanted = datePlanted
        self.lastWatered = lastWatered
        self.estHarvestDate = estHarvestDate
        self.additionalInformation = additionalInformation
        self.vegetable = vegetable
        
    }
    
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
    
    func daysSinceWater() -> Int {
        //hard coded test value
        return 2
    }
    
}
