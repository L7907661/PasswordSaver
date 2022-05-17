//
//  PassDocumentController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/17/22.
//

import Foundation
import Firebase

class PassDocumentController{
    var lastest:  Pass?
    
    static let shared = PassDocumentController()
    var _collectionRef: CollectionReference
    
    private init() {
        _collectionRef = Firestore.firestore().collection("Password")
    }
    
    func startListening(for documentId: String, changeListener: @escaping (() -> Void)) -> ListenerRegistration {
        let query = _collectionRef.document(documentId)
        
        return query.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard document.data() != nil else {
              print("Document data was empty.")
              return
            }
//            print("Current data: \(data)")
            self.lastest = Pass(documentSnapshot: document)
            changeListener()
          }
    }
    
    func stopListening(_ listenerRegistration: ListenerRegistration?) {
//        print("Removing the listener")
        listenerRegistration?.remove()
    }
    
    
    func update(_ mq: Pass) {
        _collectionRef.document(lastest!.documentID!).updateData([
            kname: mq.name,
            kpassword: mq.password,
            knote: mq.note,
            kpassId: mq.id,
            ksalt: mq.salt,
            isEn: mq.isEnp,
            kcategory: mq.category,
            ksite: mq.site,
            "user": AuthManager.shared.currentUser!.email,
            kMovieQuoteLastTouched : Timestamp.init()
            
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
//    func add(_ mq:MovieQuote){
//
//    }
//
//    func delete(_ documentId: String){
//
//    }
//    func update (quote: String, movie: String){
////        let docid = latestMQ.documentID
////        let query =
//        _collectionRef.document(latestMQ!.documentID!).updateData([
//            kMovieQuoteQuote: quote
//            kMovieQuoteMovie: movie
//            kMovieQuoteLastTouched: Timestamp.init()
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//    }
}
