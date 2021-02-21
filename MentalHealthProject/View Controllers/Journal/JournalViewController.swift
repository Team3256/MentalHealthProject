//
//  JournalViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/20/21.
//

import UIKit

class JournalViewController: UIViewController {

    @IBOutlet weak var journalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        journalLabel.text = "BG #: \(journalBGNum)"
        
        switch bg {
        case 1:
            view.backgroundColor = .cyan
        case 2:
            view.backgroundColor = .yellow
        case 3:
            view.backgroundColor = .red
        case 4:
            view.backgroundColor = .orange
        case 5:
            view.backgroundColor = .systemPink
        case 6:
            view.backgroundColor = .gray
        case 7:
            view.backgroundColor = .lightGray
        case 8:
            view.backgroundColor = .brown
        case 9:
            view.backgroundColor = .green
        default:
            view.backgroundColor = .white
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
