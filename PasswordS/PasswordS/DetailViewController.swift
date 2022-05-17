//
//  DetailViewController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 4/23/22.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {

   
    @IBOutlet weak var Strong: UIView!
    @IBOutlet weak var middle: UIView!
    @IBOutlet weak var weak: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    @IBOutlet weak var URLAtTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    @IBOutlet weak var alterbutton: UIButton!
    @IBOutlet weak var SiteButton: UIButton!
    var contentDocument : ContentDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SiteButton.isEnabled = false
        
//        alterbutton.isEnabled = false
//        alterbutton.isHidden = true
      
//        weak.backgroundColor = .gray
//        middle.backgroundColor = .gray
//        Strong.backgroundColor = .gray
        // Do any additional setup after loading the view.
    }
    func getsalt(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }

    @IBAction func alterMessage(_ sender: Any) {
        let alertController = UIAlertController(title: "Passwor Suggestions", message: "Recommend the password include at least one number, Uppercase letter, special character. And have length more than 10 character", preferredStyle: UIAlertController.Style.actionSheet)

   //     cancel
            let cancelaction = UIAlertAction(title: "Got It!", style: UIAlertAction.Style.cancel) { action in
                print("cancel pressed")
            }
            alertController.addAction(cancelaction)
            present(alertController, animated: true)
    }
    @IBAction func pressedSave(_ sender: Any) {
        print("You pressed save")
        //TODO: save to firestore
        let ss = getsalt(of: 4)
        if isswith.isOn == true{
            let passw = SimpleEncrypt.shared.encryptMessage(message: passwordTextLabel.text!, encryptionKey: ss)
            let p = Pass(name: nameTextField.text!, id: IDTextField.text!, pass: passw, site: URLAtTextField.text! , note:  notesTextField.text!, category: categoryTextField.text! , isEnp: isswith.isOn, salt: ss)
            PassFileController.shared.add(p)
        }else{
            let p2 = Pass(name: nameTextField.text!, id: IDTextField.text!, pass: passwordTextLabel.text!, site: URLAtTextField.text! , note:  notesTextField.text!, category: categoryTextField.text! , isEnp: isswith.isOn, salt: ss)
            PassFileController.shared.add(p2)
        }
        
      
        self.performSegue(withIdentifier: "BacktoMain", sender: self)
    }
    
    
//    @IBAction func pressedCancel(_ sender: Any) {
//        print("You pressed cancel")
//        self.performSegue(withIdentifier: "BacktoMain", sender: self)
//    }
    
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
//        var containsupper: Bool = false
//        let ss: String  = passwordTextLabel.text! as! String;
//        let letters = NSCharacterSet.letters
//
//        let range = ss.rangeOfCharacter(from: letters)
//        if let haveletter = range {
//            Strong.backgroundColor = .yellow
//        }
//        if passwordTextLabel.text!.count <= 6{
//            alterbutton.isHidden = false
//
//            weak.backgroundColor = .red
//
//        }else if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: passwordTextLabel.text!)){
//
//            weak.backgroundColor = .red
//        }else if containsupper == true{
//            middle.backgroundColor = .blue
//        }
        
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
    @IBAction func WanttoEncrpyt(_ sender: Any) {
        
    }
    //Detail From https://stackoverflow.com/questions/25945324/swift-open-link-in-safari
}
