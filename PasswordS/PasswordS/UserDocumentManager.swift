//
//  UserDocumentManager.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import Firebase

class UserDocumentManager {
    var _latestdocument: DocumentSnapshot?
    static let shared = UserDocumentManager()
    var _collectionRef: CollectionReference
    
    private init() {
        _collectionRef = Firestore.firestore().collection("Users")
    }
    func addNewUsermight(uid: String, name: String? , email : String? ){
//        if exsisting user, do nothing. If no user document, make it with name and photourl
        let docref = _collectionRef.document(uid)
        docref.getDocument { (document, error) in
            if let document = document, document.exists{
                print("Document exist, do nothing. \(document.data())")
            }else{
                docref.setData(["username": name  ?? "",
                                "userEmail": email ?? ""])
            }
            
        }
    }
    
    func startListening(for documentId: String, changeListener: @escaping (() -> Void)) -> ListenerRegistration {
        
        let query = _collectionRef.document(documentId)
        print(documentId)
        return query.addSnapshotListener { documentSnapshot, error in
            self._latestdocument = nil
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard document.data() != nil else {
              print("Document data was empty.")
              return
            }
//            print("Current data: \(data)")
            self._latestdocument = document
            changeListener()
          }
    }
    
    func stopListening(_ listenerRegistration: ListenerRegistration?) {
//        print("Removing the listener")
        listenerRegistration?.remove()
    }
    
    var Username: String {
        if let name = _latestdocument?.get("username"){
            return name as! String
        }
        return ""
    }
    
    var useremail: String {
        if let ee = _latestdocument?.get("userEmail"){
            return ee as! String
        }
        return ""
    }
    
    func updatename(name: String) {
        _collectionRef.document(_latestdocument!.documentID).updateData([
            "username": name,

        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
}
