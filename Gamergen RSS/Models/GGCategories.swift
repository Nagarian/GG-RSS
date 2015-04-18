//
//  Categories.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation
import UIKit

// Cette structure sert de "base de données" concernant les catégories disponibles au sein de l'application
public struct GGCategories {
    public static var array = [
        GGCategory(name: "Global", tag: "global", color: UIColor(netHex:0xEC2F2F)),
        GGCategory(name: "PS4", tag: "ps4", color: UIColor(netHex:0x8888FF)),
        GGCategory(name: "XBox One", tag: "xbox-one", color: UIColor(netHex:0x44BB44)),
        GGCategory(name: "Wii U", tag: "wii-u", color: UIColor(netHex:0x77CCEE)),
        GGCategory(name: "PS3", tag: "ps3", color: UIColor(netHex:0xAA88EE)),
        GGCategory(name: "XBox 360", tag: "xbox-360", color: UIColor(netHex:0x99CC33)),
        GGCategory(name: "Wii", tag: "wii", color: UIColor(netHex:0x66CCCC)),
        GGCategory(name: "PS Vita", tag: "ps-vita", color: UIColor(netHex:0x6688FF)),
        GGCategory(name: "2DS/3DS", tag: "n3ds", color: UIColor(netHex:0xFF7733)),
        GGCategory(name: "PSP", tag: "psp", color: UIColor(netHex:0xFF6666)),
        GGCategory(name: "DS", tag: "ds", color: UIColor(netHex:0xFF9933)),
        GGCategory(name: "PC", tag: "pc", color: UIColor(netHex:0x66BBFF)),
        GGCategory(name: "Android", tag: "android", color: UIColor(netHex:0x66DD44)),
        GGCategory(name: "iOS", tag: "ios", color: UIColor(netHex:0x77AAEE)),
        GGCategory(name: "Windows Phone", tag: "windows-phone", color: UIColor(netHex:0x8888EE))]
    
    // Cette méthode sert à récupérer la catégorie correpondant au nom passé en paramètre
    public static func getCategoryByName(value : String) -> GGCategory? {
        return GGCategories.array.filter({ (cat) -> Bool in
            cat.name.localizedCaseInsensitiveCompare(value) == NSComparisonResult.OrderedSame
        }).first
    }
    
    // Cette méthode sert à récupérer la catégorie correspondant au tag passé en paramètre
    public static func getCategoryByTag(value : String) -> GGCategory? {
        return GGCategories.array.filter({ (cat) -> Bool in
            cat.tag.localizedCaseInsensitiveCompare(value) == NSComparisonResult.OrderedSame
        }).first
    }
}