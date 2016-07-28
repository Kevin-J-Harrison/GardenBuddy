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
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var weatherTextRepLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var degrees: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        parseWeatherRequest()
    }
    
    func parseWeatherRequest() {
        var city: String?
        var state: String?
        var userInput = "Coram, NY"
        if let rangeOfComma = userInput.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch)  {
            // Found a zero, get the following text
            state = String(userInput.characters.suffixFrom(rangeOfComma.endIndex))
            print(state)
            city = String(userInput.characters.prefixUpTo(rangeOfComma.endIndex.advancedBy(-2)))
            
            print(city)
        }
        var requestURL: NSURL
        if city != nil || state != nil {
            requestURL = NSURL(string: "http://api.wunderground.com/api/e46f36320707687d/geolookup/conditions/q/\(state!)/\(city!).json")!
        }
        else {
            requestURL = NSURL(string: "http://api.wunderground.com/api/e46f36320707687d/geolookup/conditions/q/MI/Allendale.json")!
        }
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
                    //self.weatherImage?.
                    //self.weatherImage?.loadImageFromURL(NSURL(string: images.rawString()!), placeholderImage: self.videoImage?.image, cachingKey: images.rawString())
                    
                    //This works well.
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