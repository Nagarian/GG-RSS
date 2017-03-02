//
//  DetailArticleViewController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 13/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

// Controller de la vue affichant le détail d'un article
internal class DetailArticleViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    private var article : GGArticle?
    
    // Cette propriété permet de définir le contexte de la vue, à savoir l'article en cours de lecture
    internal var Article : GGArticle? {
        get {
            return article
        }
        
        set(value) {
            self.article = value
        }
    }

    // Méthode initialisant la vue
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        if article != nil {
            webView.loadRequest(URLRequest(url: self.article!.link as URL))
            self.title = self.article?.title
        }
    }
}
