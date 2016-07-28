//
//  FirstViewController.swift
//  GardenBuddy
//
//  Created by X Code User on 7/26/16.
//  Copyright © 2016 Kevin & Scott. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var weatherTextRepLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBAction func changeCityText(sender: UITextField) {
        parseWeatherRequest()
    }
    @IBOutlet weak var changeCityField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var degrees: UILabel!
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        parseWeatherRequest()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeScreenViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func parseWeatherRequest() {
        var city: String?
        var state: String?
        var userInput = changeCityField.text
        
        if userInput != "" {
            NSUserDefaults.standardUserDefaults().setObject(userInput, forKey: "savedCity")
        }
        
        if  let saved = NSUserDefaults.standardUserDefaults().stringForKey("savedCity") {
            userInput = saved
        }

        
        
        if let rangeOfComma = userInput!.rangeOfString(", ", options: NSStringCompareOptions.BackwardsSearch)  {
            // Found a zero, get the following text
            state = String(userInput!.characters.suffixFrom(rangeOfComma.endIndex))
            print(state)
            city = String(userInput!.characters.prefixUpTo(rangeOfComma.endIndex.advancedBy(-2)))
            
            print(city)
        }
        var requestURL: NSURL
        
        if city != nil && state != nil {
            city = city!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            do {
            try requestURL = NSURL(string: "http://api.wunderground.com/api/e46f36320707687d/geolookup/conditions/q/\(state!)/\(city!).json")!
            }
            catch let error as NSError {
                requestURL = NSURL(string: "http://api.wunderground.com/api/e46f36320707687d/geolookup/conditions/q/MI/Allendale.json")!
            }
            
            
        }
        else {
            requestURL = NSURL(string: "http://api.wunderground.com/api/e46f36320707687d/geolookup/conditions/q/MI/Allendale.json")!
        }
       
        print(requestURL)
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
                    
                    let images = json["current_observation"]["icon_url"]
                    let imagesString = images.rawString()!
                    let imageUrl = NSURL(string: imagesString)
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        let data = NSData(contentsOfURL: imageUrl!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                        dispatch_async(dispatch_get_main_queue(), {
                            self.weatherImage.image = UIImage(data: data!)
                            self.cityLabel.text = "\(json["current_observation"]["display_location"]["full"])"
                            self.degrees.text = "\(json["current_observation"]["feelslike_f"]) \u{00B0} \(json["current_observation"]["weather"])"
                            self.weatherTextRepLabel.text = "Precip today: \(json["current_observation"]["precip_today_string"])"
                            precip = "\(json["current_observation"]["precip_today_metric"])"
                            self.updatedAtLabel.text = "\(json["current_observation"]["observation_time"])"
                        });
                    }
                    print("We are in \(json["location"]["city"])")
                    print("It is \(json["current_observation"]["feelslike_f"]) degrees")
                }
            
            
            }
            
        }
        
        task.resume()

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