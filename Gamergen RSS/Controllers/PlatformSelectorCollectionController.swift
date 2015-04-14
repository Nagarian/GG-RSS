//
//  PlatformSelectorCollectionViewController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 14/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

let reuseIdentifier = "PlatformSelectorIdentifier"

class PlatformSelectorCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate, UICollectionViewDelegate {
    
    private var currentCategory : GGCategory?
    private var currentCategoryCell : CategoryCollectionViewCell?
    
    internal var CurrentCategory : GGCategory? {
        get {
            return currentCategory
        }
        
        set(value) {
            self.currentCategory = value
        }
    }
    
    weak var articleFeed : ArticlesFeedController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    /*override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 0
    }*/


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return GGCategories.array.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlatformCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        cell.Category = GGCategories.array[indexPath.item]
        
        var bool = cell.Category?.tag == self.currentCategory?.tag
        cell.isSelected(bool)
        if bool {
            currentCategoryCell = cell
        }
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var currentCell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryCollectionViewCell

        if currentCell.Category?.tag != currentCategory?.tag {
            currentCell.isSelected(true)
            if currentCategoryCell != nil {
                currentCategoryCell?.isSelected(false)
            }
            
            self.currentCategoryCell = currentCell
            self.currentCategory = currentCell.Category
            goBack()
        }
    }
    
    private func goBack() {
        
        var tmpController :UIViewController! = self.presentingViewController;
        articleFeed?.changeCategory(currentCategory!)
        
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            self.articleFeed = nil
        });
    }
}
