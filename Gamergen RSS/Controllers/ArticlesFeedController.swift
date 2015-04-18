
//
//  ArticlesFeedController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 11/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

class ArticlesFeedController: UITableViewController {
    
    private var articlesFeed : GGArticles?
    private var downloader : Downloader?
    
    private var category : GGCategory?
    
    @IBOutlet weak var navigationTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let savedCategory = defaults.objectForKey("category") as? String {
            self.category = GGCategories.getCategoryByTag(defaults.objectForKey("category") as! String)
        } else {
            self.category = GGCategories.getCategoryByName("Global")
        }
        
        initializeFeed()
            
        self.navigationController?.popViewControllerAnimated(true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if  articlesFeed != nil {
            return articlesFeed!.feed.count
        }
        else {
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCustomCellGG", forIndexPath: indexPath) as! ArticleTableViewCell
       // let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Default Cell View")
       
        cell.Article = articlesFeed?.feed[indexPath.item]
        cell.color = category!.color
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    internal func changeCategory(cat : GGCategory) {
        self.category = cat
        initializeFeed()

        // Sauvegarde de la catégorie actuelle pour la prochaine réouverture de l'application
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.category!.tag, forKey: "category")
        defaults.synchronize()
    }
    
    private func initializeFeed() {
        downloader = Downloader(categorie: category!)
        downloader?.download({ (feed, error) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    var alert = UIAlertController(title: "Une erreur est survenue", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            } else {
                self.articlesFeed = feed
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.tableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: true)
                    
                    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(NSDate(), forKey: "lastArticleRead")
                    defaults.synchronize()
                })
            }
        })
        
        /*self.navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x1D1D1D)
        self.navigationController?.navigationBar.tintColor = category?.color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : category!.color]*/
        
        navigationTitle.title = (self.category?.name == "Global") ? "Gamergen" : self.category!.name
        self.navigationController?.navigationBar.barTintColor = category?.color
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let argument = sender as! ArticleTableViewCell
            let destinationVC = segue.destinationViewController as! DetailArticleViewController
            
            destinationVC.Article = argument.Article
        }
        
        if segue.identifier == "PopPlateformSelector" {
            let popoverViewController = segue.destinationViewController as! PlatformSelectorCollectionViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = popoverViewController
            
            popoverViewController.CurrentCategory = category
            popoverViewController.articleFeed = self
        }
    }
}
		