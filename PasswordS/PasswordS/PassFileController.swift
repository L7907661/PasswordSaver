//
//  PassFileController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import Firebase

//import firebase
class PassFileController {
    static let shared = PassFileController()
    var _collectionRef: CollectionReference
    
    private init(){
        _collectionRef = Firestore.firestore().collection("Password")
    }
    var lastestfile = [Pass]()
    func startlistengin(filterByAuthor authorFilter: String?, changeListener: @escaping (() -> Void)) -> ListenerRegistration {
//        receive a changelistener
        var query = _collectionRef.order(by: "lastTouch", descending: true).limit(to: 50)
        if let authorFilter = authorFilter {
            print("current user is \(authorFilter)")
            query = query.whereField("user", isEqualTo: authorFilter)
        }
        return query.addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
//                let movie = documents.map { $0["name"]! }
//                print("load movie: \(movie)")
            self.lastestfile.removeAll()
            for document in documents {
//                print("\(document.documentID) => \(document.data())")
                self.lastestfile.append(Pass(documentSnapshot: document))
            }
            changeListener()
            }
    }
    
    func stoplistening(_ listnerRegistration: ListenerRegistration?){
        print("stop lisenting")
        listnerRegistration?.remove()
    }
    
    func add(_ mq: Pass){
        var ref: DocumentReference? = nil
        ref = _collectionRef.addDocument(data: [
            kname:mq.name,
            kpassword:mq.password,
            knote:mq.note,
            kpassId:mq.id,
            ksalt: mq.salt,
            isEn: mq.isEnp,
            kcategory: mq.category,
            ksite: mq.site,
            "user": AuthManager.shared.currentUser!.email,
            kMovieQuoteLastTouched : Timestamp.init()
                                               
        ]) { err in
            if let err = err {
                print("Error adding document \(err)")
            }
        }
    }
    
    func delete(_ documentId: String){
        _collectionRef.document(documentId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        
    }
}
