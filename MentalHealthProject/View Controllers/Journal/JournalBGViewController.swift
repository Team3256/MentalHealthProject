//
//  JournalBGViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/20/21.
//

import UIKit

var bg = 0

class JournalBGViewController: UIViewController {

    @IBOutlet weak var myJour: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myJour.layer.cornerRadius = 30
        myJour.backgroundColor = .systemGray //orange-yellow
        myJour.setTitleColor(.green, for: .normal) //usafa blu
        myJour.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func journal1Press(_ sender: Any) {
        bg = 1
    }
    
    @IBAction func journal2Press(_ sender: Any) {
        bg = 2
    }
    
    @IBAction func journal3Press(_ sender: Any) {
        bg = 3
    }
    
    @IBAction func journal4Press(_ sender: Any) {
        bg = 4
    }
    
    @IBAction func journal5Press(_ sender: Any) {
        bg = 5
    }
    
    @IBAction func journal6Press(_ sender: Any) {
        bg = 6
    }

    @IBAction func journal7Press(_ sender: Any) {
        bg = 7
    }
    
    @IBAction func journal8Press(_ sender: Any) {
        bg = 8
    }
    
    @IBAction func journal9Press(_ sender: Any) {
        bg = 9
    }

}
