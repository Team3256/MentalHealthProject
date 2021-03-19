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
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleTextFieldsub(titleField)
        
        saveButton.layer.cornerRadius = 30
        saveButton.setTitleColor(.green, for: .normal) //orange yellow
        saveButton.backgroundColor = .systemGray //usafa blu
        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        titleField.text = ""
        bodyText.text = "Start journaling!"
        
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        view.addGestureRecognizer(tapGesture)
        
        survey()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func tapOutside() {
        print("Handling tap!")
        view.endEditing(true)
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
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random()*(max-min)+min
    }

    func randomWorkout() -> String{
        let rNum = Int(random(min: 1, max: 10))
        
        switch rNum {
        case 1:
            return "15 minute walk!"
        case 2:
            return "10 minute run!"
        case 3:
            return "12 minute jog!"
        case 4:
            return "cardio workout of your choice!"
        case 5:
            return "exercise of sit-ups (20 count)!"
        case 6:
            return "quick 25 minute bicycle ride!"
        case 7:
            return "\(Int(random(min: 1, max: 3))) mile walk!"
        case 8:
            return "\(Int(random(min: 1, max: 3))) mile run!"
        case 9:
            return "\(Int(random(min: 1, max: 3))) mile jog!"
        case 10:
            return "\(Int(random(min: 2, max: 5))) mile bike ride!"
        default:
            return "exercise of your choice!"
        }
    }
    
    @IBAction func pressSave(_ sender: Any) {
        var hasTitle = false
        var hasBody = false
        
        if titleField.text == nil || titleField.text == "" {
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.titleField.center.x += 20
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.titleField.center.x -= 40
            }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.titleField.center.x += 20
            }, completion: nil)
        } else {
            hasTitle = true
        }
        
        if bodyText.text == nil || bodyText.text == "" || bodyText.text == "Start journaling!" {
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.bodyText.center.x += 20
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.bodyText.center.x -= 40
            }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.bodyText.center.x += 20
            }, completion: nil)
        } else {
            hasBody = true
        }
        
        if hasBody{
            if hasTitle {
                let ac = UIAlertController(title: "Thanks for adding!", message: "Now that you have finished a journal, lets try doing a(n) \(randomWorkout())", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "I'm Done!", style: .default, handler: nil))
                self.present(ac, animated: true, completion: nil)
                
                let journal = Journal(context: context)
                journal.happinessSurvey = emojiFeeling
                journal.title = titleField.text!
                journal.bodyJournal = bodyText.text!
                
                try! context.save()
            }
        }
    }
}
