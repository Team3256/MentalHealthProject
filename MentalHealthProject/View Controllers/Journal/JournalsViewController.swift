//
//  JournalsViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/22/21.
//

import UIKit

var emojiFeeling = ""

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class JournalsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleField.delegate = self
        
        Utilities.styleTextFieldsub(titleField)
        
        Utilities.styleButton(saveButton)
        
        titleField.text = ""
        bodyText.text = "Start journaling!"
        
        bodyText.backgroundColor = .clear
        
        switch bg {
        case 1:
            view.backgroundColor = .cyan
            bodyText.textColor = .black
            titleField.textColor = .black
        case 2:
            view.backgroundColor = .systemYellow
            bodyText.textColor = .black
            titleField.textColor = .black
        case 3:
            view.backgroundColor = .lightGray
            bodyText.textColor = .black
            titleField.textColor = .black
        case 4:
            view.backgroundColor = .systemOrange
            bodyText.textColor = .black
            titleField.textColor = .black
        case 5:
            view.backgroundColor = .systemPink
            bodyText.textColor = .black
            titleField.textColor = .black
        case 6:
            view.backgroundColor = .gray
            bodyText.textColor = .black
            titleField.textColor = .black
        case 7:
            view.backgroundColor = .systemRed
            bodyText.textColor = .white
            titleField.textColor = .white
        case 8:
            view.backgroundColor = .brown
            bodyText.textColor = .white
            titleField.textColor = .white
        case 9:
            view.backgroundColor = .systemIndigo
            bodyText.textColor = .white
            titleField.textColor = .white
        default:
            view.backgroundColor = .white
            bodyText.textColor = .black
            titleField.textColor = .black
        }
        
        survey()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                
                titleField.text = ""
                bodyText.text = "Start journaling..."
                
                try! context.save()
                
                self.performSegue(withIdentifier: "saveAs", sender: nil)
            }
        }
    }
}
