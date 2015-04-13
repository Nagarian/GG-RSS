//
//  DetailArticleViewController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 13/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

class DetailArticleViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    private var article : GGArticle?
    
    internal var Article : GGArticle? {
        get {
            return article
        }
        
        set(value) {
            self.article = value
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if article != nil {
            webView.loadRequest(NSURLRequest(URL: self.article!.link))
            self.title = self.article?.title
        }
        
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
