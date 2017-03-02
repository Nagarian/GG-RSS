//
//  GGArticle.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 07/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation

// Cette structure sert à définir un article au sein de l'application (permet d'avoir une meilleure abstraction du flux RSS)
public struct GGArticle {
    public let title : String // titre de l'article
    public let link : URL // lien menant à l'article
    public let description : String // description de l'article (résumé)
    public let publicationDate : String // date de publication de l'article
    public let imagePath : URL // lien de l'image accompagnant l'article
}
