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
var currentUserName = ""

class SignInViewController: UIViewController {
    

    @IBOutlet weak var usrField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @objc func handleGoogleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

extension SignInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        currentUserName = user?.profile.givenName ?? "N/A"
        currentUserName += " "
        currentUserName += user?.profile.familyName ?? "N/A"
        
        currentUserEmail = user?.profile.email ?? "N/A"
        
        print(currentUserName)
        print(currentUserEmail)
    }
}
