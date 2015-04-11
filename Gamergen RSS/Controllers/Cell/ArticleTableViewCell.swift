//
//  ArticleTableViewCell.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 11/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageElement: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var article : GGArticle?
    
    internal var Article : GGArticle? {
        get {
            return article
        }
        
        set(value) {
            self.article = value        }
    }
    
    override func layoutSubviews() {
    }
    
    internal func initialize() {
        
        titleLabel.text = article!.title
        descriptionLabel.text = article?.description
        dateLabel.text = article?.publicationDate
        imageElement.image = UIImage(data: NSData(contentsOfURL: article!.imagePath)!)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
