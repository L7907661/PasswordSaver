//
//  ContentDocument.swift
//  PasswordS
//
//  Created by Zeyu Liao on 4/27/22.
//

import Foundation

class ContentDocument{
    
    var name: String?
    var ID: String!
    var password: String!
    var URLAt: String?
    var notes: String?
    var category: String!
    var title: String!
    
    
    init(_ name: String? = "",_ ID: String, password: String,_ URLAt: String? = "",_ notes: String? = "",_ category: String,_ title: String){
        self.name = name
        self.ID = ID
        self.password = password
        self.URLAt = URLAt
        self.notes = notes
        self.category = category
        self.title = title
    }
    
    
}
