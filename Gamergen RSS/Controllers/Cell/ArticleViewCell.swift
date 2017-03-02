//
//  ArticleTableViewCell.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 11/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

// Controller des cellules affichant un article
internal class ArticleViewCell: UITableViewCell {
    
    // Outlet de la cellule
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageElement: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    private var article : GGArticle?
    
    // Cette propriété permet de définir le contexte de la cellule à savoir l'article
    internal var Article : GGArticle? {
        get {
            return article
        }
        
        set(value) {
            self.article = value
            initialize()
        }
    }
    
    // Cette propriété permet se modifier la couleur du texte du titre
    internal var color : UIColor {
        get {
            return titleLabel.tintColor
        }
        
        set(value) {
            titleLabel.textColor = value
        }
    }
    
    
    // Méthode permettant d'initialiser la cellule avec les informations provenant de l'article
    private func initialize() {
        self.titleLabel.text = self.article!.title
        self.descriptionLabel.text = self.article?.description
        self.dateLabel.text = self.article?.publicationDate
        if let d = try? Data(contentsOf: self.article!.imagePath as URL) {
            self.imageElement.image = UIImage(data: d)
        }
    }
}
