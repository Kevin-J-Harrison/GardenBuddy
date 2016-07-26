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
    var type: String
    var datePlanted: NSDate
    var lastWatered: NSDate
    var estHarvestDate: NSDate
    var additionalInformation: String
    //var some picture
    var currentWaterLevel: Double = 30.0
    
    init (maxWaterLevel: Double, type: String, datePlanted: NSDate, lastWatered: NSDate, estHarvestDate: NSDate, additionalInformation: String) {
        
        self.maxWaterLevel = maxWaterLevel
        self.type = type
        self.datePlanted = datePlanted
        self.lastWatered = lastWatered
        self.estHarvestDate = estHarvestDate
        self.additionalInformation = additionalInformation
        
    }
    
    func calculateWaterLevel() {
        let rightNow = NSDate()
        rightNow (datePlanted.timeIntervalSince1970)
    }
    
}
