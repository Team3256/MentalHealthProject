//
//  TherapistViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit
import CloudKit

class Therapist: NSObject {
    var name: String!
    var phoneNum: String!
    var email: String!
    var aboutMe: String!
}

class TherapistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var therapist = [Therapist]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TherapistTableViewCell.nib(), forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        loadTherapists()
    }
    
    func loadTherapists() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Therapist", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 50
        
        var allther = [Therapist]()
        
        operation.recordFetchedBlock = { record in
            let ther = Therapist()
            ther.name = record["name"]
            print(ther.name!)
            ther.phoneNum = record["phoneNumber"]
            ther.email = record["email"]
            ther.aboutMe = record["aboutMe"]
            allther.append(ther)
            
            print("Fetched!")
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ContentCreatorFrameViewController.isDirty = false
                    self.therapist = allther
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
        return therapist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TherapistTableViewCell
        cell.configure(therapist[indexPath.row].name, therapist[indexPath.row].phoneNum)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let ac = UIAlertController(title: "\(therapist[indexPath.row].name!)", message: "\(therapist[indexPath.row].phoneNum!) \t \(therapist[indexPath.row].email!) \n \(therapist[indexPath.row].aboutMe!)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func fetchFromCK() {
        
    }

}
