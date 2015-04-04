//
//  Categories.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation
import UIKit

struct GGCategories {
    let array: [GGCategory]
    
    init() {
        array = [GGCategory]()
        array.append(GGCategory(name: "Global", tag: "global", color: UIColor(netHex:0xEC2F2F)))
        array.append(GGCategory(name: "PS4", tag: "ps4", color: UIColor(netHex:0x8888FF)))
        array.append(GGCategory(name: "XBox One", tag: "xbox-one", color: UIColor(netHex:0x44BB44)))
        array.append(GGCategory(name: "Wii U", tag: "wii-u", color: UIColor(netHex:0x77CCEE)))
        array.append(GGCategory(name: "PS3", tag: "ps3", color: UIColor(netHex:0xAA88EE)))
        array.append(GGCategory(name: "XBox 360", tag: "xbox-360", color: UIColor(netHex:0x99CC33)))
        array.append(GGCategory(name: "Wii", tag: "wii", color: UIColor(netHex:0x66CCCC)))
        array.append(GGCategory(name: "PS Vita", tag: "ps-vita", color: UIColor(netHex:0x6688FF)))
        array.append(GGCategory(name: "2DS/3DS", tag: "n3ds", color: UIColor(netHex:0xFF7733)))
        array.append(GGCategory(name: "PSP", tag: "psp", color: UIColor(netHex:0xFF6666)))
        array.append(GGCategory(name: "DS", tag: "ds", color: UIColor(netHex:0xFF9933)))
        array.append(GGCategory(name: "PC", tag: "pc", color: UIColor(netHex:0x66BBFF)))
        array.append(GGCategory(name: "Android", tag: "android", color: UIColor(netHex:0x66DD44)))
        array.append(GGCategory(name: "iOS", tag: "ios", color: UIColor(netHex:0x77AAEE)))
        array.append(GGCategory(name: "Windows Phone", tag: "windows-phone", color: UIColor(netHex:0x8888EE)))
    }
    
    func getCategoryByName(value : String) -> GGCategory? {
        return array.filter({ (cat) -> Bool in
            cat.name == value
        }).first
    }
    
    func getCategoryByTag(value : String) -> GGCategory? {
        return array.filter({ (cat) -> Bool in
            cat.tag == value
        }).first
    }
}