//
//  DetailViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit
<<<<<<< HEAD
=======
import THCalendarDatePicker
import SmileWeather
>>>>>>> 94711cf2f3e1f91c4f4977fe87bb7ca2b7f5019e

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var lastWatered: UIButton!
    var curDate : NSDate = NSDate()
    var lastWateredDate : NSDate = NSDate()
    
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
        setupView()
        print(curDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
<<<<<<< HEAD
=======
    func refreshTitle(datePicker: THDatePickerViewController!) {
        if datePicker == self.datePicker {
            self.dateButton.setTitle("Date Planted " + formatter.stringFromDate(datePicker.date), forState: UIControlState.Normal)
        }
        else {
            self.lastWatered.setTitle("Last Watered "  + formatter.stringFromDate(datePicker.date), forState: UIControlState.Normal)
        }
    }
>>>>>>> 94711cf2f3e1f91c4f4977fe87bb7ca2b7f5019e
    
    func setupView() {
        self.view.backgroundColor = bgColorCode
    }

    /*
    // MARK: - Navigation
    */
    
    func cancel(sender: AnyObject) {
        print("CANCEL")
        self.navigationController?.popViewControllerAnimated(true)
    }
<<<<<<< HEAD
=======
    
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
            lastWateredDate = waterDatePicker.date
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

>>>>>>> 94711cf2f3e1f91c4f4977fe87bb7ca2b7f5019e

}
