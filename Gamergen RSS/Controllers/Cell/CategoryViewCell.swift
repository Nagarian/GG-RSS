//
//  CategoryCollectionViewCell.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 14/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

// Controller des cellules affichant une catégroie
internal class CategoryViewCell: UICollectionViewCell {
    
    // outlet de la cellule
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageElement: UIImageView!
    
    
    private var category : GGCategory?
    
    // Cette propriété permet de définir la catégorie et lancer l'initialisation de la cellule
    internal var Category : GGCategory? {
        get {
            return category
        }
        
        set(value) {
            self.category = value
            initialize()
        }
    }
    
    
    // Méthode permettant d'initialiser la cellule avec les informations provenant de la catégorie
    private func initialize() {
        self.titleLabel.text = self.category!.name
        self.titleLabel.textColor = self.category!.color
        self.imageElement.image =  UIImage(named: self.category!.tag)?.imageWithRenderingMode(.AlwaysTemplate)
        self.imageElement.tintColor = self.category!.color
    }
    
    // Méthode permettant de switcher l'état de la cellule pour montrer laquelle est sélectionnée
    internal func isSelected(value: Bool) {
        if value {
            self.titleLabel.textColor = UIColor.whiteColor()
            self.imageElement.tintColor = UIColor.whiteColor()
            self.backgroundColor = self.category!.color
        } else {
            self.titleLabel.textColor = self.category!.color
            self.imageElement.tintColor = self.category!.color
            self.backgroundColor = nil
        }
    }
}
