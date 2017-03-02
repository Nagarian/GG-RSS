//
//  Downloader.swift
//  Gamergen RSS
//
//  Created by Nagarian47 on 04/04/2015.
//  Copyright (c) 2015 Nagarian47. All rights reserved.
//

import Foundation

// Classe s'occupant de télécharger les flux RSS en provenance de Gamergen
internal class Downloader {
    private let request : URLRequest
    private let category: GGCategory
    
    internal init (categorie : GGCategory) {
        var uri = "https://www.gamergen.com/rss"
        if (categorie.name != "Global") {
            uri += "/" + categorie.tag
        }
        
        request = URLRequest(url: URL(string: uri)!)
        self.category = categorie
    }
    
    // Méthode téléchargeant le flux correspond à la catégorie défini au sein de la classe, la méthode callback prend en arguments :
    // - data : GGCategories contenant le flux RSS parser et traiter
    // - error : String donnant les détails si une erreur s'est produite
    internal func download(_ callback: @escaping (GGArticles?, String?) -> Void) {
        httpGet(request, callback: {(data, error) in
            if error != nil {
                callback(nil, error)
                return
            }
            
            // Ceci provient de la librairie externe importé avec cocoapods
            let xml = SWXMLHash.parse(data)
            
            let articles = GGArticles(title: xml["rss"]["channel"]["title"].element!.text!, category : self.category)
            
            for item in xml["rss"]["channel"]["item"] {
                articles.feed.append(GGArticle(
                    title : item["title"].element!.text!,
                    link : URL(string: item["link"].element!.text!)!,
                    description : item["description"].element!.text!,
                    publicationDate : item["pubDate"].element!.text!,
                    imagePath : URL(string: (item["enclosure"].element!.attribute(by: "url")?.text)!)!))
            }
            
            callback(articles, nil)
        })
    }
    
    // Méthode trouvée sur internet :-)
    private func httpGet(_ request: URLRequest!, callback: @escaping (String, String?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                callback("", error?.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    String.Encoding.utf8.rawValue)!
                callback(result as String, nil)
            }
        })
        
        task.resume()
    }
}
