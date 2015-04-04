//
//  Downloader.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation

internal class Downloader {
    private let request : NSURLRequest
    
    init (categorie : GGCategory) {
        var url = "http://www.gamergen.com/rss"
        if (categorie.name != "Global") {
            url += "/" + categorie.tag
        }
        
        request = NSURLRequest(URL: NSURL(string: url)!)
    }
    
    internal func download(callback: (String, String?) -> Void) {
        httpGet(request, callback)
    }
    
    private func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error.localizedDescription)
            } else {
                var result = NSString(data: data, encoding:
                    NSASCIIStringEncoding)!
                callback(result, nil)
            }
        }
        task.resume()
    }
}
