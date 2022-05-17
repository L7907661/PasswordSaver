//
//  TableViewController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 4/23/22.
//

import UIKit
import Firebase

class TableTagcell : UITableViewCell {
    @IBOutlet weak var labelcontent: UILabel!
    
    @IBOutlet weak var taglabel: UILabel!
   

    
}

class TableViewController: UITableViewController {
    let kcell = "PasswordCell"
    var passFile = [Pass]()

    var ListenerRegistrqtion: ListenerRegistration?
    var logouthandle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

 
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(showAddQuoteDialog))
//        show a dialog menu
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "☰", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showMenuDialog))
  
    }
         
 @objc func showMenuDialog() {
     let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
//     show all quote/ show my quote
    
     let createquoteaction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) { action in
            self.isEditing = !self.isEditing
                 }
         alertController.addAction(createquoteaction)
//     edit profile
     let profileaction = UIAlertAction(title: "Edit Profile", style: UIAlertAction.Style.default) { action in
         print("sign out pressed")
         self.performSegue(withIdentifier: "ProfilePage", sender:self)
     }
     alertController.addAction(profileaction)
//     sign out
     let signoutaction = UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.default) { action in
         print("sign out pressed")
         AuthManager.shared.signOut()
     }
     alertController.addAction(signoutaction)
//     cancel
         let cancelaction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
             print("cancel pressed")
         }
         alertController.addAction(cancelaction)
         present(alertController, animated: true)
        }
                                                                 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("add listener")
    startlisteningforMQ()
        logouthandle = AuthManager.shared.addlogoutObserver{
                print("sign out")
                  self.navigationController?.popViewController(animated: true)
        
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stoplisteningMQ()
        AuthManager.shared.removeObserver(logouthandle)
    }
    func startlisteningforMQ(){
        stoplisteningMQ() //do nothing
        ListenerRegistrqtion = PassFileController.shared.startlistengin(filterByAuthor: AuthManager.shared.currentUser?.email, changeListener:{
               self.tableView.reloadData()
           }
        )
    }
    
    func stoplisteningMQ(){
        PassFileController.shared.stoplistening(ListenerRegistrqtion)
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(PassFileController.shared.lastestfile.count)
        return  PassFileController.shared.lastestfile.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kcell, for: indexPath) as! TableTagcell
        
        // Configure the cell..
//        cell.quotelabel.text = moviequotes[indexPath.row].quote
//        cell.movielabel.text = moviequotes[indexPath.row].movie
        let mq = PassFileController.shared.lastestfile
//        print(mq[indexPath.row].name)

        cell.labelcontent.text = mq[indexPath.row].category
        cell.taglabel.text = mq[indexPath.row].name
        return cell
    }
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return AuthManager.shared.currentUser!.uid == PassFileController.shared.lastestmovieQuotes[indexPath.row].AuthUID
//    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mqTodeleteid = PassFileController.shared.lastestfile[indexPath.row]
            PassFileController.shared.delete(mqTodeleteid.documentID!)
//            moviequotes.remove(at: indexPath.row)
//            tableView.reloadData()
        }
    }

    @IBAction func create(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoCreate", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DeatilAboutPassSegue" {
            let mqdetailvc = segue.destination as! PasswordViewController
           if let indexpath = tableView.indexPathForSelectedRow{
//               mqdetail.moviequote = movieQuotes[indexpath.row]
//               mqdetailvc.moviequote = moviequoteCollectionManager.shared.lastestmovieQuotes[indexpath.row]
               mqdetailvc.documentID = PassFileController.shared.lastestfile[indexpath.row].documentID
            }
        }

    }

}
