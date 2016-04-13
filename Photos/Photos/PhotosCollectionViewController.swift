//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    @IBOutlet var collectionViewOutlet: UICollectionView!
    var photos: [Photo]!
    //var dict: NSDictionary = ["likes" : 0, "username" : "", "url" : "", "date" : 0]
//    var select = Photo.init(data: dict)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
//        print("wat") 
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let downloadQueue = dispatch_queue_create("com.iShots.processdownload", nil)
        
        dispatch_async(downloadQueue) {
            let data = NSData(contentsOfURL: NSURL(string: photo.url)!)
            var image : UIImage?
            if data != nil {
                photo.imageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
//                self.selected.image = image
            }
        }
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionViewOutlet.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        let photo = self.photos[indexPath.row]

        loadImageForCell(photo, imageView: cell.imageView)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos != nil {
            return self.photos.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showImage", sender: self)
//        select = self.photos[indexPath.row]
//        let cell = collectionViewOutlet.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
//        loadImageForCell(select, imageView: cell.imageView)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            let indexPaths = self.collectionView?.indexPathsForSelectedItems()!
//            let indexPath = indexPaths![0] as NSIndexPath
//            let show = segue.destinationViewController as? ShowImageViewController
//            let show?.selectedImage = selected
//            let show.userLabel =
//            let show.dateLabel =
//            let show.numLikesLabel =
        }
    }
}