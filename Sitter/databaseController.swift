//
//  databaseController.swift
//  Sitter
//
//  Created by ECE Tech on 25/03/2018.
//  Copyright © 2018 ECE Tech. All rights reserved.
//
import UIKit

protocol DBDelegate
{
    func dataLoaded(datas:ITunesAPIResults?)
}

class databaseController: NSObject {
    
    var delegate : DBDelegate? = nil
    var database = ITunesAPIResults()
    
    func loadData()
    {
        //https://rss.itunes.apple.com/api/v1/fr/books/top-free/all/10/explicit.json
        
        
        
        if let url = URL(string : "https://rss.itunes.apple.com/api/v1/fr/books/top-free/all/10/explicit.json")
        {
            
            // Le dataTask appel la fonction dans un autre thread on est donc en sychrone avec le thread principal
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data , error == nil else{
                    print("Erreur de chargement de data")
                    DispatchQueue.main.async {
                        self.delegate?.dataLoaded(datas: nil)
                    }
                    return
                }
                do{
                    let root = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let rootDict = root as? [String : Any]
                    {
                        if let feed = rootDict["feed"] as? [String : Any]
                        {
                            if let title = feed["title"] as? String{
                                self.database.title = title
                                print("titre : \(title)")
                            }
                            
                            if let id = feed["id"] as? String
                            {
                                print("id : \(id)")
                            }
                            
                            if let results =  feed["results"] as? [[String : Any]]
                            {
                                for result in results
                                {
                                    var book = Book()
                                    if let artistName = result["artistName"] as? String
                                    {
                                        book.author = artistName
                                        print("artiste : \(artistName)")
                                    }
                                    if let name = result["name"] as? String
                                    {
                                        book.name = name
                                        print("Nom : \(name)")
                                    }
                                    
                                    if let id = result["id"] as? String
                                    {
                                        print("id : \(id)")
                                    }
                                    
                                    if let releaseDate = result["releaseDate"] as? String
                                    {
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.date(from: releaseDate)
                                        print("Release date : \(releaseDate)")
                                    }
                                    
                                    if let name = result["name"] as? String
                                    {
                                        print("Name : \(name)")
                                    }
                                    
                                    if let kind = result["kind"] as? String
                                    {
                                        print("kind : \(kind)")
                                    }
                                    
                                    if let artistId = result["artistId"] as? String
                                    {
                                        print("artistId : \(artistId)")
                                    }
                                    
                                    if let artistUrl = result["artistUrl"] as? String
                                    {
                                        //book.url = artistUrl
                                        print("artistUrl : \(artistUrl)")
                                    }
                                    
                                    if let artworkUrl100 = result["artworkUrl100"] as? String
                                    {
                                        print("artworkUrl100 : \(artworkUrl100)")
                                    }
                                    
                                    if let genres = result["genres"] as? [[String : String]]
                                    {
                                        for genre in genres
                                        {
                                            
                                            var genreObject = Genre()
                                            if let idString = genre["genreId"]
                                            {
                                                if let idNum = Int(idString)
                                                {
                                                    genreObject.id = idNum
                                                }
                                                print("genreId : \(idString)")
                                            }
                                            
                                            if let name = genre["name"]
                                            {
                                                genreObject.name = name
                                                print("name : \(name)")
                                            }
                                            
                                            if let url = genre["url"]
                                            {
                                                print("url : \(url) \n")
                                            }
                                            
                                            book.genre.append(genreObject)
                                        }
                                    }
                                    self.database.books.append(book)
                                }
                            }
                            
                            // dispatchQueue est un objet qui permet de representer les threads
                            // le main represente le thread principal
                            // le .async permet de passer en mode assychrone avec le thread principale
                            DispatchQueue.main.async {
                                self.delegate!.dataLoaded(datas: self.database )
                            }
                            
                        }
                    } // if let rootDict ...
                    
                }
                catch{
                    
                }
            }).resume()
            print("start DL")
        }
        
        
        
    }
    
    func load()-> Bool
    {
        loadData()
        
        return false
    }
}
