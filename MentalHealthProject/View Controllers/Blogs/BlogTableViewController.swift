//
//  BlogTableViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/18/21.
//

import UIKit
import CloudKit

class Blog: NSObject {
    var title: String!
    var body: String!
}

var blog = Blog()

class BlogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blogViewButton: UIButton!
    
    var blogs = [Blog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        loadBlogs()
        tableView.reloadData()
        
        blogViewButton.layer.cornerRadius = 30
        blogViewButton.setTitleColor(.blue, for: .normal)
        blogViewButton.backgroundColor = .systemGray
    }
    
    @objc func tapOutside() {
        
        print("Tap Handling!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        loadBlogs()
    }
    
    func loadBlogs() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        let query = CKQuery(recordType: "Blog", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 50
        
        var newBlog = [Blog]()
        
        operation.recordFetchedBlock = { record in
            let blog = Blog()
            blog.title = record["titleField"]
            print(blog.title!)
            blog.body = record["blogBody"]
            newBlog.append(blog)
            
            print("Fetched!")
        }
        
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ContentCreatorFrameViewController.isDirty = false
                    self.blogs = newBlog
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
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        blogViewButton.setTitle(blogs[indexPath.row].title, for: .normal)
        
        blog = blogs[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //TODO: give cell defining properties, and customize the cell with custom UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = blogs[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
