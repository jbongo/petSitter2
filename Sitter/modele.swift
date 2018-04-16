//
//  modele.swift
//  Sitter
//
//  Created by ECE Tech on 25/03/2018.
//  Copyright © 2018 ECE Tech. All rights reserved.
//

import Foundation

/*class Artist
 {
 var author = ""
 
 }*/

class Genre
{
    var id = 0
    var name = ""
    var url = ""
}

class Book
{
    var author = ""
    var id = ""
    var name = ""
    
    var url = ""
    var artistId = 0
    
    var genre = [ Genre ]()
    
    var releaseDate : Date? = nil
}

class ITunesAPIResults
{
    var title = ""
    
    var books = [ Book ]()
}



