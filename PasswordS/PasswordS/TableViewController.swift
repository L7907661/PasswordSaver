//
//  TableViewController.swift
//  PasswordS
//
//  Created by Zeyu Liao on 4/23/22.
//

import UIKit

class TableTagcell : UITableViewCell {
    @IBOutlet weak var labelcontent: UILabel!
    var tagall = [String]()

    
}
class Tabledetailcell : UITableViewCell {
   
    @IBOutlet weak var detailcontent: UILabel!
    var detail = [String]()

}
class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
