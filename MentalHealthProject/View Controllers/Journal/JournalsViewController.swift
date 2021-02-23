//
//  JournalsViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/22/21.
//

import UIKit

var emojiFeeling = ""

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class JournalsViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        survey()
    }
    
    func survey() {
        let alert = UIAlertController(title: "How is has your day been so far?", message: "Use the emojis to let us know how your day has gone so far.", preferredStyle: .actionSheet)
        
        let excellentEmoji = UIAlertAction(title: "😆", style: .default) { (alert) in
            emojiFeeling = "😆" //very good
        }
        
        let happyEmoji = UIAlertAction(title: "😊", style: .default) { (alert) in
            emojiFeeling = "😊" //good
        }
        
        let neutralEmoji = UIAlertAction(title: "😐", style: .default) { (alert) in
            emojiFeeling = "😐" //idc / idk
        }
        
        let sadEmoji = UIAlertAction(title: "😟", style: .default) { (alert) in
            emojiFeeling = "😟" //sad
        }
        
        let depressedEmoji = UIAlertAction(title: "😭", style: .default) { (alert) in
            emojiFeeling = "😭" //depression
        }
        
        alert.addAction(excellentEmoji)
        alert.addAction(happyEmoji)
        alert.addAction(neutralEmoji)
        alert.addAction(sadEmoji)
        alert.addAction(depressedEmoji)
        
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func pressSave(_ sender: Any) {
        let journal = Journal(context: context)
        journal.happinessSurvey = emojiFeeling
        journal.title = titleField.text!
        journal.bodyJournal = bodyText.text!
        
        try! context.save()
    }
}
