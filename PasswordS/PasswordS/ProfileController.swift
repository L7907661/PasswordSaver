//
//  ProfileController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import Firebase
import UIKit

class ProfileController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var cencelbutton: UIButton!
    @IBOutlet weak var chengetextbox: UITextField!
    @IBOutlet weak var save: UIButton!
    var userreg: ListenerRegistration?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chengetextbox.isHidden = true
       
        save.isHidden = true
        userreg = UserDocumentManager.shared.startListening(for: AuthManager.shared.currentUser!.uid){
            self.updateView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDocumentManager.shared.stopListening(userreg)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveppressed(_ sender: Any) {
        UserDocumentManager.shared.updatename(name: chengetextbox.text!)
        changeButton.isHidden = false
        chengetextbox.isHidden = true
       
        save.isHidden = true
        
    }

    
    @IBAction func changepressed(_ sender: Any) {
        
        chengetextbox.isHidden = false
        changeButton.isHidden = true
        save.isHidden = false
        chengetextbox.text = UserDocumentManager.shared.Username
        updateView()
    }
 
    func updateView(){
        email.text = UserDocumentManager.shared.useremail
        name.text = UserDocumentManager.shared.Username
    }

}
    
