//
//  SignInViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/24/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

var currentUserEmail = ""


class SignInViewController: UIViewController {
    

    @IBOutlet weak var usrField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleTextFieldmain(usrField)
        Utilities.styleTextFieldmain(pwField)
        
        nextButton.isHidden = true

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func signInPress(_ sender: Any) {
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
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
            //do nothing
        }))
        
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
        
        signInButton.isHidden = false
        nextButton.isHidden = false
    }
}
