//
//  GGArticle.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 07/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation

struct GGArticle {
    var title : String
    var link : NSURL
    var description : String
    var publicationDate : String
    var imagePath : NSURL
}


/*
title
link
guid
description
pubdate
enclosure <- image
media:content <- image
*/