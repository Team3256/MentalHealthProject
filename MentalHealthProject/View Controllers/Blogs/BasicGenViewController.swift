//
//  BasicGenViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit

class BasicGenViewController: UIViewController {

    @IBOutlet weak var blogB: UIButton!
    @IBOutlet weak var therapistB: UIButton!
    @IBOutlet weak var newsletterB: UIButton!
    @IBOutlet weak var faqB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleButton(blogB)
        Utilities.styleButton(therapistB)
        Utilities.styleButton(newsletterB)
        Utilities.styleButton(faqB)
    }
    
    func styleButton(_ button: UIButton) {
        button.layer.cornerRadius = 30
        button.setTitleColor(.green, for: .normal)
        button.backgroundColor = .systemGray
    }

}
