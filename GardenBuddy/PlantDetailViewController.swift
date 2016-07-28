//
//  DetailViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var lastWatered: UIButton!
    var curDate : NSDate = NSDate()
    var lastWateredDate : NSDate = NSDate()
    
    lazy var formatter: NSDateFormatter = {
        var tmpFormatter = NSDateFormatter()
        tmpFormatter.dateFormat = "dd/MM/yyyy --- HH:mm"
        return tmpFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       let cancelButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        //refreshTitle()
        setupView()
        print(curDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupView() {
        self.view.backgroundColor = bgColorCode
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func cancel(sender: AnyObject) {
        print("CANCEL")
        self.navigationController?.popViewControllerAnimated(true)
    }

}
