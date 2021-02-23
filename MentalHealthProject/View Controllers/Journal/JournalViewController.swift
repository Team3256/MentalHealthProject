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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        filterSearch.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*TODO*/
        
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }

}
