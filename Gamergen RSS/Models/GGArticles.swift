//
//  File.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 07/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation

struct GGArticles {
    var feed : [GGArticle]
    let title : String
    let category : GGCategory
    
    init(title : String, category : GGCategory) {
        self.feed = [GGArticle]()
        self.title = title
        self.category = category
    }
}