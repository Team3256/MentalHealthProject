//
//  AddReviewViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit
import CloudKit

class AddReviewViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ratingName: UITextField!
    @IBOutlet weak var body: UITextView!
    @IBOutlet weak var rating: UITextField!
    @IBOutlet weak var err: UILabel!
    @IBOutlet weak var publish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingName.delegate = self
        rating.delegate = self
        
        Utilities.styleTextFieldsub(rating)
        Utilities.styleTextFieldsub(ratingName)
        Utilities.styleButton(publish)
        
        err.alpha = 0
    }
    
    @IBAction func pressSave(_ sender: Any) {
        let bg = Int(rating.text ?? "0") ?? 0
        
        if bg > 0 && bg <= 5 {
            let txt = ratingName.text
            
            if txt == "" || txt == nil {
                showError("Missing rating name!")
            } else {
                let body = self.body.text
                
                if body == "" || body == nil || body == "Review here..." {
                    showError("Missing reason of review!")
                } else {
                    saveToCK(txt!, body!, bg)
                }
            }
            
        } else {
           showError("Missing rating!")
        }
    }
    
    func showError(_ err: String) {
        self.err.alpha = 1
        self.err.text = err
    }
    
    func saveToCK(_ name: String, _ reason: String, _ rating: Int) {
        //instantiate blog
        let myReview = CKRecord(recordType: "Review")
        myReview["title"] = name as CKRecordValue
        myReview["body"] = reason as __CKRecordObjCValue
        myReview["rating"] = rating as CKRecordValue
        myReview["company"] = currentSel.name as CKRecordValue
        myReview["name"] = currentUserEmail as CKRecordValue
        
        //try save
        CKContainer.default().publicCloudDatabase.save(myReview) { [unowned self]record, error in
            DispatchQueue.main.async {
                if let _ = error {
                    //error occurred while saving the blog
                    self.showError(error!.localizedDescription)
                    print("Error occurred while saving!")
                    self.view.backgroundColor = .red
                } else {
                    //saved the blog
                    print("Saved!")
                    self.view.backgroundColor = .systemGreen
                    
                    ContentCreatorFrameViewController.isDirty = true
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
