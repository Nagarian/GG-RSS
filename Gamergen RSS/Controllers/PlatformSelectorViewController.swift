//
//  PlatformSelectorCollectionViewController.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 14/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

let reuseIdentifier = "PlatformSelectorIdentifier"

internal class PlatformSelectorViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate {
    
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
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // Méthode permettant d'activer le mode popup sur iPhone
    internal func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    // Méthode retournant le nombre d'éléments dans le tableView
    internal override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GGCategories.array.count
    }

    // Méthode initialisant chacune des celules à partir de l'élément lié
    internal override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCell", for: indexPath) as! CategoryViewCell
        cell.Category = GGCategories.array[indexPath.item]
        
        let bool = cell.Category?.tag == self.currentCategory?.tag
        cell.isSelected(bool)
        if bool {
            currentCategoryCell = cell
        }
        
        return cell
    }

    // Méthode changeant la catégorie sélectionnée
    internal override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! CategoryViewCell

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
        self.articleFeedController?.changeCategory(currentCategory!)
        
        self.dismiss(animated: false, completion: {()->Void in
            self.articleFeedController = nil
        });
    }
}
