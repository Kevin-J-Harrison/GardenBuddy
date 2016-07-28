//
//  AddPlantViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit
import THCalendarDatePicker

class AddPlantViewController: UIViewController, THDatePickerDelegate {
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var lastWatered: UIButton!
    @IBOutlet weak var plantType: UITextField!
    @IBOutlet weak var requiredWater: UITextField!
    var curDate : NSDate = NSDate()
    var lastWateredDate : NSDate = NSDate()
    
    lazy var formatter: NSDateFormatter = {
        var tmpFormatter = NSDateFormatter()
        tmpFormatter.dateFormat = "MM/dd/yyyy"
        return tmpFormatter
    }()

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
    
        func refreshTitle(datePicker: THDatePickerViewController!) {
            if datePicker == self.datePicker {
                dateButton.setTitle("Date Planted: " + formatter.stringFromDate(datePicker.date), forState: UIControlState.Normal)
            }
            else {
                lastWatered.setTitle("Last Watered On: " + formatter.stringFromDate(datePicker.date), forState: UIControlState.Normal)
            }
        }
    
    lazy var datePicker:THDatePickerViewController = {
        var dp = THDatePickerViewController.datePicker()
        dp.delegate = self
        dp.setAllowClearDate(false)
        dp.setClearAsToday(true)
        dp.setAutoCloseOnSelectDate(false)
        dp.setAllowSelectionOfSelectedDate(true)
        dp.setDisableHistorySelection(false)
        dp.setDisableFutureSelection(false)
        //dp.autoCloseCancelDelay = 5.0
        dp.selectedBackgroundColor = UIColor(red: 125/255.0, green: 208/255.0, blue: 0/255.0, alpha: 1.0)
        dp.currentDateColor = UIColor(red: 242/255.0, green: 121/255.0, blue: 53/255.0, alpha: 1.0)
        dp.currentDateColorSelected = UIColor.yellowColor()
        return dp
    }()
    
    lazy var waterDatePicker:THDatePickerViewController = {
        var dp = THDatePickerViewController.datePicker()
        dp.delegate = self
        dp.setAllowClearDate(false)
        dp.setClearAsToday(true)
        dp.setAutoCloseOnSelectDate(false)
        dp.setAllowSelectionOfSelectedDate(true)
        dp.setDisableHistorySelection(false)
        dp.setDisableFutureSelection(false)
        //dp.autoCloseCancelDelay = 5.0
        dp.selectedBackgroundColor = UIColor(red: 125/255.0, green: 208/255.0, blue: 0/255.0, alpha: 1.0)
        dp.currentDateColor = UIColor(red: 242/255.0, green: 121/255.0, blue: 53/255.0, alpha: 1.0)
        dp.currentDateColorSelected = UIColor.yellowColor()
        return dp
    }()
    
    @IBAction func dateButtonTouched(sender: AnyObject) {
        datePicker.date = self.curDate
        datePicker.setDateHasItemsCallback { (date: NSDate!) -> Bool in
            let tmp = (arc4random() % 30)+1
            return (tmp % 5 == 0)
        }
        presentSemiViewController(datePicker, withOptions: [
            convertCfTypeToString(KNSemiModalOptionKeys.shadowOpacity) as String! : 0.3 as Float,
            convertCfTypeToString(KNSemiModalOptionKeys.animationDuration) as String! : 1.0 as Float,
            convertCfTypeToString(KNSemiModalOptionKeys.pushParentBack) as String! : false as Bool
            ])
    }
    
    @IBAction func lastWateredButtonTouched(sender: AnyObject) {
        waterDatePicker.date = self.lastWateredDate
        waterDatePicker.setDateHasItemsCallback { (date: NSDate!) -> Bool in
            let tmp = (arc4random() % 30)+1
            return (tmp % 5 == 0)
        }
        presentSemiViewController(waterDatePicker, withOptions: [
            convertCfTypeToString(KNSemiModalOptionKeys.shadowOpacity) as String! : 0.3 as Float,
            convertCfTypeToString(KNSemiModalOptionKeys.animationDuration) as String! : 1.0 as Float,
            convertCfTypeToString(KNSemiModalOptionKeys.pushParentBack) as String! : false as Bool
            ])
    }
    
    /* https://vandadnp.wordpress.com/2014/07/07/swift-convert-unmanaged-to-string/ */
    func convertCfTypeToString(cfValue: Unmanaged<NSString>!) -> String?{
        /* Coded by Vandad Nahavandipoor */
        let value = Unmanaged<CFStringRef>.fromOpaque(
            cfValue.toOpaque()).takeUnretainedValue() as CFStringRef
        if CFGetTypeID(value) == CFStringGetTypeID(){
            return value as String
        } else {
            return nil
        }
    }
    
    // MARK: THDatePickerDelegate
    
    func datePickerDonePressed(datePicker: THDatePickerViewController!) {
        
        if datePicker == self.datePicker {
            curDate = datePicker.date
            print("Date Picked Set")
        }
        else {
            lastWateredDate = self.waterDatePicker.date
            print("Last Watered Set")
        }
        
        dismissSemiModalView()
        refreshTitle(datePicker)
        print(curDate)
    }
    
    func datePickerCancelPressed(datePicker: THDatePickerViewController!) {
        dismissSemiModalView()
    }
    
    func datePicker(datePicker: THDatePickerViewController!, selectedDate: NSDate!) {
        print("Date selected: ", formatter.stringFromDate(selectedDate))
    }

}
