//
//  SpecBlogViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit

class SpecBlogViewController: UIViewController {

    @IBOutlet weak var titleLabe: UILabel!
    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabe.text = blog.title
        body.text = blog.body
    }

}
