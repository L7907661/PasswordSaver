//
//  Pass.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import Firebase
class Pass{
    var name: String
    var id: String
    var password: String?
    var site: String?
    var note: String?
    var category: String?
    var salt: String?
    var isEnp: Bool?
    var documentID: String?
    var userEmail: String?
    init(name : String, id: String, pass: String, site: String, note:String, category: String, isEnp:Bool, salt: String){
        self.name = name
        self.id = id
        self.password = pass
        self.site = site
        self.category = category
        self.isEnp = isEnp
        self.salt = salt
        self.note = note
    }
    
    init(documentSnapshot: DocumentSnapshot){
        let data = documentSnapshot.data()
        self.name = data?["name"] as? String ?? ""
        self.id = data?["ID"] as? String ?? ""
        self.password = data?["password"] as? String ?? ""
        self.site = data?["Atsite"] as? String ?? ""
        self.note = data?["note"] as? String ?? ""
        self.category = data?["category"] as? String ?? ""
        self.salt = data?["salt"] as? String ?? ""
        self.isEnp = data?["isEnp"] as? Bool ?? false
        self.userEmail = data?["user"] as? String ?? ""
        self.documentID = documentSnapshot.documentID
    }
}
