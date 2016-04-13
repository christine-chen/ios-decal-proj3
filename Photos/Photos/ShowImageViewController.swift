//
//  ShowImageViewController.swift
//  Photos
//
//  Created by Christine Chen on 4/9/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {

    @IBOutlet var selectedPhoto: UIImageView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var numLikesLabel: UILabel!
    
    var pic = UIImage()
    var name = String()
    var date = String()
    var likes = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.text = "@" + name
        selectedPhoto.image = pic
//        selectedPhoto.loadPhoto()
        dateLabel.text = date
        numLikesLabel.text = likes
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
