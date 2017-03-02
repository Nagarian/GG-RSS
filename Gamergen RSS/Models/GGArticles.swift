//
//  File.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 07/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation

// Classe décrivant le flux RSS
public class GGArticles {
    public var feed : [GGArticle] // liste des articles
    public let title : String // titre du flux actuel
    public let category : GGCategory // catégorie du flux actuel
    
    public init(title : String, category : GGCategory) {
        self.feed = [GGArticle]()
        self.title = title
        self.category = category
    }
}
