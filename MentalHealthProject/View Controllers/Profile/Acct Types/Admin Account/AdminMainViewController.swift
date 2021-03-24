//
//  AdminMainViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/21/21.
//

import UIKit
import CloudKit

class WhiteList: NSObject {
    var name: String!
}

class AdminMainViewController: UIViewController {

    @IBOutlet weak var accountsBut: UIButton!
    @IBOutlet weak var newsLetter: UIButton!
    @IBOutlet weak var errLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.errLabel.textColor = .red
        self.errLabel.text = ""
        
        Utilities.styleButton(accountsBut)
        Utilities.styleButton(newsLetter)
    }
    
    @IBAction func whitelist(_ sender: Any) {
        let ac = UIAlertController(title: "Whitelist!", message: "Type the account name of the person you would like to block.", preferredStyle: .alert)
        
        ac.addTextField { (txtfield) in
            txtfield.placeholder = "Account Name..."
        }
        
        ac.addAction(UIAlertAction(title: "BAN!", style: .destructive, handler: { (alert) in
            let text = ac.textFields![0].text!
            
            if text == "" {
                return
            } else {
                self.saveToCK(text)
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func saveToCK(_ txt: String) {
        let whitelist = CKRecord(recordType: "Whitelist")
        whitelist["name"] = txt as CKRecordValue
        
        CKContainer.default().publicCloudDatabase.save(whitelist) { [unowned self]rec, err in
            if let _ = err {
                self.showErr("\(err!.localizedDescription)")
            } else {
                self.showCorr("Whitelisted!")
            }
        }
    }
    
    func showErr(_ text: String) {
        DispatchQueue.main.async {
            self.errLabel.text = text
            self.errLabel.textColor = .red
        }
    }
    
    func showCorr(_ text: String) {
        DispatchQueue.main.async {
            self.errLabel.text = text
            self.errLabel.textColor = .green
        }
    }

}
