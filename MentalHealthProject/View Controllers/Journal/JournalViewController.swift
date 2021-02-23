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
        
        let cancelButton = UIAlertAction(title: "Done", style: .cancel) { (alert) in
            tableView.deselectRow(at: indexPath, animated: false)
        }
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let cardToRemove = self.journals[indexPath.row]

            let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this journal! This action cannot be undo-ed!", preferredStyle: .alert)

            let submitButton = UIAlertAction(title: "YES", style: .destructive) { (action) in
                context.delete(cardToRemove)
                try! context.save()
                self.fetchJournals()
            }

            alert.addAction(submitButton)

            let stopButton = UIAlertAction(title: "NO", style: .default) { (action) in
                try! context.save()
                self.fetchJournals()
            }

            alert.addAction(stopButton)
            self.present(alert, animated: true, completion: nil)

            try! context.save()
            self.fetchJournals()
        }
    
            return UISwipeActionsConfiguration(actions: [action])
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /*TODO - Filtering*/
    }

}
