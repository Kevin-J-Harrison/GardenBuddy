//
//  FirstViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
// WUG API Key: e46f36320707687d
//

import UIKit
import SwiftyJSON

class HomeScreenViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let requestURL: NSURL = NSURL(string: "http://api.wunderground.com/api/e46f36320707687d/geolookup/conditions/q/MI/Allendale.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                
                do{
                    
                    let json = JSON(data: data!)
                    //This works well.
                    print("We are in \(json["location"]["city"])")
                    print("It is \(json["current_observation"]["feelslike_f"]) degrees")
                }
                
            }
        }
        
        task.resume()
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    func setupView() {
        self.view.backgroundColor = bgColorCode
        self.titleLabel.backgroundColor = bgColorCode
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}