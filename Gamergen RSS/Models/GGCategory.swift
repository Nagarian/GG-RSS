//
//  Category.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation
import UIKit

// Cette structure définit une catégorie au sein de l'application
public struct GGCategory {
    public let name : String // Nom de la catégorie
    public let tag : String // Tag permettant d'identifier la catégorie (utilisé également pour obtenir le lien de téléchargement du flux RSS)
    public let color : UIColor // Couleur de la catégorie (code couleur récupéré au niveau du CSS du site web)
}