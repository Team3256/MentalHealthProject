//
//  SignInViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/24/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import CloudKit

var currentUserEmail = ""


class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usrField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        usrField.delegate = self
        pwField.delegate = self
        
        super.viewDidLoad()
        
        Utilities.styleTextFieldsub(usrField)
        Utilities.styleTextFieldsub(pwField)
        
        Utilities.styleButton(signInButton)
        
        nextButton.isHidden = true

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        fetchCK()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func fetchCK() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Whitelist", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 50
        
        var newWhiteList = [WhiteList]()
        
        operation.recordFetchedBlock = { record in
            let whitelist = WhiteList()
            whitelist.name = record["name"]
            newWhiteList.append(whitelist)
            
            print("Fetched!")
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ContentCreatorFrameViewController.isDirty = false
                    self.whitelisters = newWhiteList
                    
                    print("Loaded!")
                } else {
                    let ac = UIAlertController(title: "Failed to Load!", message: "Unable to fetch data... try again later or check connectivity and refresh data! \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(ac, animated: true, completion: nil)
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    var whitelisters = [WhiteList]()
    
    @IBAction func signInPress(_ sender: Any) {
        for i in whitelisters {
            if i.name == usrField.text!.trimmingCharacters(in: .whitespacesAndNewlines) {
                let ac = UIAlertController(title: "Error!", message: "You have been whitelisted, sorry your account is disabled. For more information email: myalo3256@gmail.com. Be sure to include your account email! Thank you!", preferredStyle: .alert)
                
                self.present(ac, animated: true, completion: nil)
                
                return
            }
        }
        
        guard let email = usrField.text, !email.isEmpty, let pw = pwField.text, !pw.isEmpty else {
            print("Missing info")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw, completion: {[weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                strongSelf.createAccount(email,pw)
                return
            }
            
            print("You have signed in!")
            
            currentUserEmail = email
            
            print(currentUserEmail)
            
            strongSelf.nextButton.isHidden = false
            strongSelf.googleButton.isHidden = true
            
            self!.performSegue(withIdentifier: "signedIn", sender: nil)
        })
    }
    
    func createAccount(_ email: String, _ pw: String) {
        let alert = UIAlertController(title: "Create Account", message: "Account does not exist! Would you like to create the account with credentials \(email) and \(pw)?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw) { [weak self] result, err in
                guard let strongSelf = self else {
                    return
                }
                
                guard err == nil else {
                    print("Error making account!")
                    return
                }
                
                print("You have signed in!")
                
                currentUserEmail = email
                
                print(currentUserEmail)
                
                strongSelf.nextButton.isHidden = false
                strongSelf.googleButton.isHidden = true
            }
            
            self.performSegue(withIdentifier: "signedIn", sender: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleGoogleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

extension SignInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        currentUserEmail = user?.profile.email ?? "N/A"
        print(currentUserEmail)
        
        if currentUserEmail != "N/A" {
            self.performSegue(withIdentifier: "signedIn", sender: nil)
        }
    }
}
