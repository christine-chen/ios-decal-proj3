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
    var selectUser = ""
    var selectDate = NSDate()
    var selectImage = UIImage()
    var selectLikes = 0
    
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
//        let cell = collectionViewOutlet.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        let photo = self.photos[indexPath.row]
            
//        loadImageForCell(photo, imageView: cell.imageView)
        let data = NSData(contentsOfURL: NSURL(string: photo.url)!)
        photo.imageData = data
        selectImage = UIImage(data: data!)!
        print(selectImage)
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if segue.identifier == "showImage" {
            let indexPaths = self.collectionView?.indexPathsForSelectedItems()!
            let indexPath = indexPaths![0] as NSIndexPath
            let show = segue.destinationViewController as? ShowImageViewController
            
            selectUser = self.photos[indexPath.row].username
            selectDate = self.photos[indexPath.row].datePosted
            //need to convert to string use formatter
            selectLikes = self.photos[indexPath.row].likes
//            print(selectImage.image)
            show?.name = selectUser
            show?.pic = selectImage
            print("show")
            print(show?.pic)
            print("pfs")
//            show?.dateLabel =
            show?.likes = String(selectLikes)
        }
//        collectionView?.reloadData()
    }
}