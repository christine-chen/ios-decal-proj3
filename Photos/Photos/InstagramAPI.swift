//
//  InstagramAPI.Swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class InstagramAPI {
    /* Connects with the Instagram API and pulls resources from the server. */
    func loadPhotos(completion: (([Photo]) -> Void)!) {
        /* 
         * 1. Get the endpoint URL to the popular photos 
         *    HINT: Look in Utils
         * 2. Create a Session
         * 3. Create a Data Task with a URL and completionHandler
         *    If no error:
         *       a. Get NSDictionary from the JSON object, from key the "photos"
         *       b. Create Array of NSDictionaries (one NSDictionary for each photo)
         *       c. For each NSDictionary, create a Photo object, and add to Photos array
         *       d. Wait for completion of Photos array
         */
        // FILL ME IN
        var url: NSURL
        
        url = Utils.getPopularURL()

        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                //FIX ME
                var photos: [Photo]!
                photos = [Photo]()
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    // FILL ME IN, REMEMBER TO USE FORCED DOWNCASTING
                    var arrDictionaries: [NSDictionary] = []
                    
                    var likes: Int?
                    var username: String?
                    var imageURL: String?
                    var datePost: NSDate?
                    
                    likes = 0
                    username = ""
                    imageURL = ""
                    datePost = NSDate()
                    
                    let dataArray = feedDictionary["data"] as! NSArray
//                    print("data")
                    for dada in dataArray {
                        if let like = dada["likes"] as? [String: AnyObject] {
                            likes = like["count"] as? Int
                        }
                        if let user = dada["user"] as? [String: AnyObject] {
                            username = user["username"] as? String
                        }
                        if let images = dada["images"] as? [String: AnyObject] {
                            let tempURL = images["standard_resolution"]
                            imageURL = tempURL!["url"] as? String
                        }
                        if let date = dada["created_time"] as? String {
                            datePost = NSDate.init(timeIntervalSince1970: Double(date)!)
                        }
                        let newDictionary: NSDictionary = ["likes" : likes!, "username" : username!, "url" : imageURL!, "date" : datePost!]
                            arrDictionaries.append(newDictionary)
                    }
//                        print("before loop")
                    for item in arrDictionaries {
                        let foto = Photo.init(data: item)
                        photos.append(foto)
//                        print(item.valueForKey("url"))
                    }
//                    }
                    // DO NOT CHANGE BELOW
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(photos)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}