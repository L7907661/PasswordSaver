//
//  PasswordViewController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/16/22.
//

import UIKit
import UIKit
import Foundation
import Firebase
import RNCryptor

class PasswordViewController: UIViewController {

       
        @IBOutlet weak var Strong: UIView!
        @IBOutlet weak var middle: UIView!
        @IBOutlet weak var weak: UIView!
        @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var IDTextField: UITextField!
        @IBOutlet weak var passwordTextLabel: UITextField!
        @IBOutlet weak var URLAtTextField: UITextField!
        @IBOutlet weak var categoryTextField: UITextField!
        @IBOutlet weak var notesTextField: UITextField!
        
        
        @IBOutlet weak var SiteButton: UIButton!
        var documentID: String!
        var ListenerReg: ListenerRegistration?
        var userreg: ListenerRegistration?
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            SiteButton.isEnabled = true
            updateView()
    //        alterbutton.isEnabled = false
    //        alterbutton.isHidden = true
          
            weak.backgroundColor = .gray
            middle.backgroundColor = .gray
            Strong.backgroundColor = .gray
            // Do any additional setup after loading the view.
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ListenerReg = PassDocumentController.shared.startListening(for: documentID!){
            self.updateView()
           
        }
        
    }
    
    func updateView(){
 
        let file = PassDocumentController.shared.lastest
//        print(file?.documentID)
        nameTextField.text = file?.name
        IDTextField.text  = file?.id
        if file?.isEnp == true {
            do {
             
                let dey = try SimpleEncrypt.shared.decryptMessage(encryptedMessage: file?.password ?? "", encryptionKey: file?.salt  ?? "")
                self.passwordTextLabel.text  = dey
            } catch {
                print("do nothing")
//                nothing
                self.passwordTextLabel.text  =  "***********"
            }
      



        }else{
            passwordTextLabel.text  = file?.password
        }
        if file?.isEnp == true{
            isswith.isOn = true
        }else {
            isswith.isOn = false
        }
        
        URLAtTextField.text  = file?.site
        categoryTextField.text  = file?.category
        notesTextField.text  = file?.note
        
        
        var containsupper: Bool = false
        let ss: String  = passwordTextLabel.text! as! String;
        let letters = NSCharacterSet.letters

        let range = ss.rangeOfCharacter(from: letters)
        if let haveletter = range {
            
            middle.backgroundColor = .yellow
            weak.backgroundColor = .gray
//            middle.backgroundColor = .gray
            Strong.backgroundColor = .gray
        }
        if passwordTextLabel.text!.count <= 6{

            weak.backgroundColor = .red
//            weak.backgroundColor = .gray
            middle.backgroundColor = .gray
            Strong.backgroundColor = .gray

        }else if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: passwordTextLabel.text!)){

            middle.backgroundColor = .blue
            weak.backgroundColor = .gray
//            middle.backgroundColor = .gray
            Strong.backgroundColor = .gray
        }
        else if isswith.isOn == true{
            Strong.backgroundColor = .blue
            weak.backgroundColor = .gray
            middle.backgroundColor = .gray
//            Strong.backgroundColor = .gray
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PassDocumentController.shared.stopListening(ListenerReg)
    }
        func getsalt(of length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var s = ""
            for _ in 0 ..< length {
                s.append(letters.randomElement()!)
            }
            return s
        }

    
        @IBAction func pressedSave(_ sender: Any) {
            print("You pressed save")
            //TODO: save to firestore
            let ss = PassDocumentController.shared.lastest?.salt
            
            if isswith.isOn == true{
                let passw = SimpleEncrypt.shared.encryptMessage(message: passwordTextLabel.text!, encryptionKey: ss!)
                let p = Pass(name: nameTextField.text!, id: IDTextField.text!, pass: passw, site: URLAtTextField.text! , note:  notesTextField.text!, category: categoryTextField.text! , isEnp: isswith.isOn, salt: ss!)
                PassDocumentController.shared.update(p)
            }else{
                let p2 = Pass(name: nameTextField.text!, id: IDTextField.text!, pass: passwordTextLabel.text!, site: URLAtTextField.text! , note:  notesTextField.text!, category: categoryTextField.text! , isEnp: isswith.isOn, salt: ss!)
                PassDocumentController.shared.update(p2)
            }
            
          
//            self.performSegue(withIdentifier: "BacktoMain", sender: self)
            updateView()
        }
        
        
        @IBAction func pressedCancel(_ sender: Any) {
            print("You pressed cancel")
//            self.performSegue(withIdentifier: "Back", sender: self)
        }
        
        @IBAction func typedName(_ sender: Any) {
           
            let nameText = nameTextField.text ?? ""
            print("You changed name text to \(nameText)")
        }
        
        @IBAction func typedID(_ sender: Any) {
            print("You changed ID text to \(IDTextField.text)")
        }
        
        @IBAction func typedPassword(_ sender: Any) {
            print("You changed password text to \(passwordTextLabel.text)")
            //TODO: check password complexity

            
        }
        
        
        @IBAction func typedURLAt(_ sender: Any) {
            print("You changed URL text to \(URLAtTextField.text)")
        }
        
        @IBAction func typedNotes(_ sender: Any) {
            print("You changed notes text to \(notesTextField.text)")
        }
        
        @IBAction func typedCategory(_ sender: Any) {
            print("You changed category text to \(categoryTextField.text)")
        }
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        @IBOutlet weak var isswith: UISwitch!

        //Detail From https://stackoverflow.com/questions/25945324/swift-open-link-in-safari
    
    @IBAction func GoToSite(_ sender: Any) {
        guard let url = URL(string: PassDocumentController.shared.lastest?.site ?? "") else { return }
        UIApplication.shared.open(url)
    }
    

}
