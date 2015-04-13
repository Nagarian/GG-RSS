//
//  Downloader.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation
import SWXMLHash

internal class Downloader {
    private let request : NSURLRequest
    private let category: GGCategory
    
    init (categorie : GGCategory) {
        var uri = "http://www.gamergen.com/rss"
        if (categorie.name != "Global") {
            uri += "/" + categorie.tag
        }
        
        request = NSURLRequest(URL: NSURL(string: uri)!)
        self.category = categorie
    }
    
    internal func download(callback: (GGArticles?, String?) -> Void) {
        httpGet(request, callback: {(data, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            let xml = SWXMLHash.parse(data)
            
            var articles = GGArticles(title: xml["rss"]["channel"]["title"].element!.text!, category : self.category)
            
            for item in xml["rss"]["channel"]["item"] {
                articles.feed.append(GGArticle(
                    title : item["title"].element!.text!,
                    link : NSURL(string: item["link"].element!.text!)!,
                    description : item["description"].element!.text!,
                    publicationDate : item["pubDate"].element!.text!,
                    imagePath : NSURL(string: item["enclosure"].element!.attributes["url"]!)!))
            }
            
            callback(articles, nil)
        })
    }
    
    private func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error.localizedDescription)
            } else {
                var result = NSString(data: data, encoding:
                    NSUTF8StringEncoding)!
                callback(result as String, nil)
            }
        }
        
        task.resume()
    }
}
