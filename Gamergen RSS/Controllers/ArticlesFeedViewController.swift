
//
//  ArticlesFeedController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 11/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

// Controller de la vue affichant le flux RSS
internal class ArticlesFeedViewController: UITableViewController {

    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    private var articlesFeed : GGArticles? // liste d'article
    private var category : GGCategory? // catégorie actuellement sélectionnée
    
    
    // Méthode lançant le téléchargement et initialisant l'affichage
    private func initializeFeed() {
        Downloader(categorie: category!).download({ (feed, error) -> Void in
            if error != nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    let alert = UIAlertController(title: "Une erreur est survenue", message: error, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                })
            } else {
                self.articlesFeed = feed
                DispatchQueue.main.async(execute: { () -> Void in
                    self.tableView.reloadData()
                    self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
                    
                    let defaults: UserDefaults = UserDefaults.standard
                    defaults.set(self.articlesFeed?.feed.first?.link.absoluteString, forKey: "lastArticleRead")
                    defaults.synchronize()
                })
            }
        })
        
        navigationTitle.title = (self.category?.name == "Global") ? "Gamergen" : self.category!.name
        self.navigationController?.navigationBar.barTintColor = category?.color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        // style alternatif
        /*self.navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x1D1D1D)
        self.navigationController?.navigationBar.tintColor = category?.color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : category!.color]*/
    }
    
    // Méthode permettant de changer la catégorie actuelle et de recharger la vue
    internal func changeCategory(_ cat : GGCategory) {
        self.category = cat
        initializeFeed()
        
        // Sauvegarde de la catégorie actuelle pour la prochaine réouverture de l'application
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(self.category!.tag, forKey: "category")
        defaults.synchronize()
    }
    
    // Méthode initialisant la vue
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // récupération de la catégorie lors de la précédente session
        let defaults: UserDefaults = UserDefaults.standard
        
        if let savedCategory = defaults.object(forKey: "category") as? String {
            self.category = GGCategories.getCategoryByTag(savedCategory)
        } else {
            self.category = GGCategories.getCategoryByName("Global")
        }
        
        // initilisation de la liste d'article
        initializeFeed()
            
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // Méthode retournant le nombre d'éléments dans le tableView
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  articlesFeed != nil {
            return articlesFeed!.feed.count
        }
        else {
            return 0
        }
    }
    
    // Méthode initialisant chacune des celules à partir de l'élément lié
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCellGG", for: indexPath) as! ArticleViewCell
       
        cell.Article = articlesFeed?.feed[indexPath.item]
        cell.color = category!.color
        
        return cell
    }
    
    // Méthode pour passer des arguments à la vue cible de la navigation
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // afficher des détails de l'article
        if segue.identifier == "showDetail" {
            let argument = sender as! ArticleViewCell
            let destinationVC = segue.destination as! DetailArticleViewController
            
            destinationVC.Article = argument.Article
        }
        
        // afficher le menu de la sélection de la catégorie
        if segue.identifier == "PopPlateformSelector" {
            let popoverViewController = segue.destination as! PlatformSelectorViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = popoverViewController
            
            popoverViewController.CurrentCategory = category
            popoverViewController.articleFeedController = self
        }
    }
}
		
