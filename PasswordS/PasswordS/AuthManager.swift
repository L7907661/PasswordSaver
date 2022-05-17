//
//  AuthManager.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import Firebase

class AuthManager {
    
    static let shared = AuthManager()
    private init(){
        
    }
    var currentUser: User? {
          Auth.auth().currentUser
      }
      
      var isSignedin: Bool {
          currentUser != nil
      }
    
    func addloginObserver(callback: @escaping (() -> Void)) -> AuthStateDidChangeListenerHandle{
        return Auth.auth().addStateDidChangeListener { auth, user in
            if (user != nil){
                callback()
            }
        }
    }
    func addlogoutObserver(callback: @escaping (() -> Void)) -> AuthStateDidChangeListenerHandle{
        return Auth.auth().addStateDidChangeListener { auth, user in
            if (user == nil){
                callback()
            }
        }
    }
    func removeObserver(_ authDidchangeHandle: AuthStateDidChangeListenerHandle?){
        if let authHandle = authDidchangeHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }
    func signinNewUser_emailpassword(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){ authresult, error in
            if let error = error {
                print("error at create new user\(error)")
                return
            }
            print("create new user successfuly")
            
        }
    }
    func loginExsitingUser_emailpassword(email: String, passwords: String){
        Auth.auth().signIn(withEmail: email, password: passwords){ authresult, error in
            if let error = error {
                print("error at sign in \(error)")
                return
            }
            print("sign in exsiting user successfuly")
            
        }
    }
    func loginAnonymously(){
        Auth.auth().signInAnonymously(){ authresult, error in
            if let error = error {
                print("error at sign in anonymously \(error)")
                return
            }
            print("sign in anonymously successfuly")
            
        }
    }
    
    func signOut(){
        do{
          try Auth.auth().signOut()
        }catch{
            print("Sign out error")
        }
    }
}
