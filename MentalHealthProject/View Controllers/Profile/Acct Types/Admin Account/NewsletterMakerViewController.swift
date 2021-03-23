//
//  NewsletterMakerViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/22/21.
//

import UIKit
import CloudKit

class NewsletterMakerViewController: ViewController {

    @IBOutlet weak var newsletter: UITextView!
    @IBOutlet weak var upd8Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleButton(upd8Button)
    }
    
    @IBAction func pressUpd8(_ sender: Any) {
        let letter = newsletter.text ?? ""
        
        if letter == "" || letter == "Type Newsletter..." {
            self.view.backgroundColor = .systemRed
        } else {
            save(letter)
        }
    }
    
    func save(_ letter: String) {
        //instantiate blog
        let news = CKRecord(recordType: "Newsletter")
        news["body"] = letter as __CKRecordObjCValue
        
        //try save
        CKContainer.default().publicCloudDatabase.save(news) { [unowned self]record, error in
            DispatchQueue.main.async {
                if let _ = error {
                    //error occurred while saving the blog
                    print("Error occurred while saving!")
                    self.view.backgroundColor = .red
                } else {
                    //saved the blog
                    print("Saved!")
                    self.view.backgroundColor = .green
                }
            }
        }
    }

}
