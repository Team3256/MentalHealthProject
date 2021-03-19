//
//  ProfileViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/2/21.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var journalsCompleted: UILabel!
    @IBOutlet weak var reviewsWritten: UILabel!
    @IBOutlet weak var switchAcct: UITextField!
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var contentCreatorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchAcct.delegate = self
        
        adminButton.isHidden = true
        contentCreatorButton.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if  textField.text == "stress"{
            contentCreatorButton.isHidden = false
        } else if textField.text == "admin"{
            adminButton.isHidden = false
            contentCreatorButton.isHidden = false
        } else {
            adminButton.isHidden = true
            contentCreatorButton.isHidden = true
        }
        
        return true
    }
    
    @objc func handleOutTap() {
        view.endEditing(true)
    }
}