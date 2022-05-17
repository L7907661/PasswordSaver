//
//  LogInController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import Firebase
import UIKit

class LogInControllrt: UIViewController {
    var rosefirename: String?
    
    var loginhandle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginhandle = AuthManager.shared.addloginObserver {
            print("Already someone signed in! Skip log in")
            self.performSegue(withIdentifier: "MainSegue", sender: self)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AuthManager.shared.removeObserver(loginhandle)
    }

    @IBAction func CreateUser(_ sender: Any) {
        let email = emailtextfield.text!
        let password = passwordtextfield.text!
//        print("email \(email) + password \(password)")
        AuthManager.shared.signinNewUser_emailpassword(email: email, password: password)
        
    }
    
    
    @IBAction func LoginExistingUser(_ sender: Any) {
        let email = emailtextfield.text!
        let password = passwordtextfield.text!
//        print("email \(email) + password \(password)")
        AuthManager.shared.loginExsitingUser_emailpassword(email: email, passwords: password)
    }
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        make sure segue work correctly
        if segue.identifier == "MainSegue"{
            print("segue identifier is kshowlistsegue")
//            print("Name = \(rosefirename ?? AuthManager.shared.currentUser!.displayName)")
//            print("PhotoUrl = \(AuthManager.shared.currentUser!.photoURL)")
            UserDocumentManager.shared.addNewUsermight(uid: AuthManager.shared.currentUser!.uid,
                                                       name: AuthManager.shared.currentUser!.displayName,
                                                       email: AuthManager.shared.currentUser!.email)
        }
      
        
        
    }
   
//
//    @IBAction func pressGoogleSignin(_ sender: Any) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) {user, error in
//
//          if let error = error {
//            print("Google sing in error: \(error)")
//            return
//          }
//
//          guard
//            let authentication = user?.authentication,
//            let idToken = authentication.idToken
//          else {
//            return
//          }
//
//          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                         accessToken: authentication.accessToken)
//            AuthManager.shared.signinwithGooglr(credential)
//        }
//    }
}

    

