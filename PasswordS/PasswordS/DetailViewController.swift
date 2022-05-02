//
//  DetailViewController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 4/23/22.
//

import UIKit

class DetailViewController: UIViewController {

   
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    @IBOutlet weak var URLAtTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    var contentDocument : ContentDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pressedSave(_ sender: Any) {
        print("You pressed save")
        //TODO: save to firestore
        self.contentDocument = ContentDocument(nameTextField.text!,
                                               IDTextField.text!,
                                               password: passwordTextLabel.text!,
                                               URLAtTextField.text! ,
                                               notesTextField.text! ,
                                               categoryTextField.text! ,
                                               contentDocument?.title! ?? "")
        print("You saved data as \(contentDocument?.ID) \(contentDocument?.password), \(contentDocument?.URLAt)")
    }
    
    
    @IBAction func pressedCancel(_ sender: Any) {
        print("You pressed cancel")
        
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

}
