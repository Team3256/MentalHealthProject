//
//  AdminMainViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/21/21.
//

import UIKit

class AdminMainViewController: UIViewController {

    @IBOutlet weak var accountsBut: UIButton!
    @IBOutlet weak var newsLetter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Utilities.styleButton(accountsBut)
        Utilities.styleButton(newsLetter)
    }

}
