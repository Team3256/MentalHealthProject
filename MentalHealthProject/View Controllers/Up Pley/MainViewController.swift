//
//  MainViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/22/21.
//

import UIKit
import CloudKit

class Gym: NSObject {
    var name: String!
    var phone: String!
    var web: String!
    var info: String!
}

var currentSel = Gym()

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventButton: UIButton!
    
    var gyms = [Gym]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleButton(eventButton)
        
        tableView.register(GymCell.nib(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        loadBuisiness()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GymCell
        cell.configure(gyms[indexPath.row].name, gyms[indexPath.row].phone)
        
        return cell
    }
    
    func loadBuisiness() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Gym", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 50
        
        var allGy = [Gym]()
        
        operation.recordFetchedBlock = { record in
            let gy = Gym()
            gy.name = record["name"]
            print(gy.name!)
            gy.phone = record["phoneNumber"]
            gy.web = record["website"]
            gy.info = record["info"]
            allGy.append(gy)
            
            print("Fetched!")
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ContentCreatorFrameViewController.isDirty = false
                    self.gyms = allGy
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        currentSel = gyms[indexPath.row]
        
        self.performSegue(withIdentifier: "gymSelect", sender: nil)
    }
    
}
