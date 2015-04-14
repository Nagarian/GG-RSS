//
//  CategoryCollectionViewCell.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 14/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageElement: UIImageView!
    
    private var category : GGCategory?
    
    internal var Category : GGCategory? {
        get {
            return category
        }
        
        set(value) {
            self.category = value
            initialize()
        }
    }
    
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
    
    private func initialize() {
        
        self.titleLabel.text = self.category!.name
        self.titleLabel.textColor = self.category!.color
        self.imageElement.image =  UIImage(named: self.category!.tag)?.imageWithRenderingMode(.AlwaysTemplate)
        self.imageElement.tintColor = self.category!.color
    }
}
