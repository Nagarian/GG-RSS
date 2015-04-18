//
//  PlatformSelectorCollectionViewController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 14/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

let reuseIdentifier = "PlatformSelectorIdentifier"

internal class PlatformSelectorViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate, UICollectionViewDelegate {
    
    private var currentCategory : GGCategory? // categorie sélectionnée
    private var currentCategoryCell : CategoryViewCell? // cellule sélectionnée
    
    // Catégorie actuellement sélectionnée
    internal var CurrentCategory : GGCategory? {
        get {
            return currentCategory
        }
        
        set(value) {
            self.currentCategory = value
        }
    }
    
    internal weak var articleFeedController : ArticlesFeedViewController?

    
    // Méthode initialisant la vue
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // Méthode permettant d'activer le mode popup sur iPhone
    internal func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

    // Méthode retournant le nombre d'éléments dans le tableView
    internal override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GGCategories.array.count
    }

    // Méthode initialisant chacune des celules à partir de l'élément lié
    internal override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlatformCell", forIndexPath: indexPath) as! CategoryViewCell
        cell.Category = GGCategories.array[indexPath.item]
        
        var bool = cell.Category?.tag == self.currentCategory?.tag
        cell.isSelected(bool)
        if bool {
            currentCategoryCell = cell
        }
        
        return cell
    }

    // Méthode changeant la catégorie sélectionnée
    internal override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var currentCell = collectionView.cellForItemAtIndexPath(indexPath) as! CategoryViewCell

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
    
    // Méthode permettant de fermer popup (cette vue-ci)
    private func goBack() {
        var tmpController :UIViewController! = self.presentingViewController;
        self.articleFeedController?.changeCategory(currentCategory!)
        
        self.dismissViewControllerAnimated(false, completion: {()->Void in
            self.articleFeedController = nil
        });
    }
}
