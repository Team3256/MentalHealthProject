//
//  JournalViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 2/20/21.
//

import UIKit

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterSearch: UITextField!
    
    var journals = [Journal]()
    var filteredJournals = [Journal]()
    var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        filterSearch.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        try! context.save()
        self.tableView.reloadData()
        fetchJournals()
    }
    
    func fetchJournals() {
        journals = try! context.fetch(Journal.fetchRequest())
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredJournals.isEmpty {
            return filteredJournals.count
        }
        
        return isFiltered ? 0: journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        var jour: Journal
        
        if !filteredJournals.isEmpty {
            jour = filteredJournals[indexPath.row]
        } else {
            jour = journals[indexPath.row]
        }
        
        cell.textLabel?.text = jour.title! + " " + jour.happinessSurvey!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currentJour = Journal()
        
        if !filteredJournals.isEmpty {
            currentJour = filteredJournals[indexPath.row]
        } else {
            currentJour = journals[indexPath.row]
        }
        
        let alert = UIAlertController(title: currentJour.title! + " " + currentJour.happinessSurvey!, message: currentJour.bodyJournal, preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "Back", style: .cancel) { (alert) in
            tableView.deselectRow(at: indexPath, animated: false)
        }
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /*TODO - Filtering*/
    }

}
