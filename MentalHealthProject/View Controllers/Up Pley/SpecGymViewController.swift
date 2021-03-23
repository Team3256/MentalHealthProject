//
//  SpecGymViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit
import CloudKit
import MessageUI

class Reviews: NSObject {
    var name: String!
    var rating: Int!
    var reason: String!
    var uName: String!
}

class SpecGymViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addRating: UIButton!
    @IBOutlet weak var revLabel: UILabel!

    var rev = [Reviews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleButton(addRating)
        nameLabel.text = currentSel.name
        bodyText.text = "\(currentSel.info!) \nPhone: \(currentSel.phone!)\nWebsite: \(currentSel.web!)"
        
        // Do any additional setup after loading the view.
        tableView.register(RevCell.nib(), forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
        
        loadRev()
    }

    var sumRev = 0
    var count = 0
    
    var reviewTargetName = ""
    var reviewGymRep = ""
    
    func loadRev() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Review", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 50
        
        var allRev = [Reviews]()
        
        operation.recordFetchedBlock = { record in
            let review = Reviews()
            
            if record["company"] == currentSel.name {
                review.name = record["title"]
                print(review.name!)
                review.reason = record["body"]
                review.rating = record["rating"]
                review.uName = record["name"]
                self.sumRev += review.rating
                self.count+=1
                allRev.append(review)
            }
            print("Fetched!")
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ContentCreatorFrameViewController.isDirty = false
                    self.rev = allRev
                    self.tableView.reloadData()
                    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rev.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RevCell
        cell.configure(rev[indexPath.row].name, rev[indexPath.row].rating)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentRev = rev[indexPath.row]
        
        let ac = UIAlertController(title: "\(currentRev.name!) || \(currentRev.rating!)/5", message: "\(currentRev.reason!)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "Report", style: .destructive, handler: { (alert) in
            self.reviewGymRep = currentRev.name
            self.reviewTargetName = currentRev.uName
            
            self.report()
        }))
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func report() {
        let ac = UIAlertController(title: "Remember!", message: "When reporting, please make sure you include the user's name, and gym they posted on and why is this against the guidelines?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Report", style: .destructive, handler: { (alert) in
            self.sendMail()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func sendMail() {
        if canSend() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["myalo3256@gmail.com"])
            composer.setMessageBody("Report Name: \(self.reviewTargetName) \nReview of Gym: \(self.reviewGymRep) \nReason: ...Give reason here...", isHTML: false)
            composer.setSubject("Report on: \(self.reviewTargetName)")
            
            present(composer, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Error!", message: "Your device cannot send mail, please make sure to email your report claim to myalo3256@gmail.com!", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
    }
    
    func canSend() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
}

extension SpecGymViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            let ac = UIAlertController(title: "Error!", message: "Error occurred with loading the email", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            return
        }
        
        if result == .cancelled {
            print("Email cancelled!")
        } else if result == .failed {
            let ac = UIAlertController(title: "Failed!", message: "Email failed to send!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        } else if result == .saved {
            let ac = UIAlertController(title: "Draft!", message: "Email wasn't sent, draft was saved though!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        } else if result == .sent {
            let ac = UIAlertController(title: "Sent!", message: "We have recieved your email are undergoing investigations into the problem. Please check your email for a response with requests or resolution!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
    }
    
}
