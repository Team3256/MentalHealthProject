//
//  ContentCreatorFrameViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/1/21.
//

import UIKit
import CloudKit

class ContentCreatorFrameViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var blogImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var blogPost: UITextView!
    
    private let image = UIImagePickerController()
    
    static var isDirty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.delegate = self
        titleField.delegate = self
        blogPost.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapOutside() {
        print("Handling tap!")
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let alert = UIAlertController(title: "Image Selection", message: "How would you like to select your image?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (alert) in
            self.photoLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.camera()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addBlog(_ sender: Any) {
        titleField.resignFirstResponder()
        blogPost.resignFirstResponder()
        
        var noTitle = false
        var noBlog = false
        
        if titleField.text == nil || titleField.text == ""{
            print("No Title")
            
            titleField.textColor = .red
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.titleField.center.x += 20
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.titleField.center.x -= 40
            }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.titleField.center.x += 20
            }, completion: nil)
            
            noTitle = true
        }
        
        if blogPost.text == nil || blogPost.text == "" || blogPost.text == "Blog Post..." {
            print("No Blog!")
            
            blogPost.textColor = .red
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.blogPost.center.x += 20
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.blogPost.center.x -= 40
            }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.blogPost.center.x += 20
            }, completion: nil)
            
            noBlog = true
        }
        
        
        
        if noBlog || noTitle {
            //do nothing, my brain hurt rn
        } else {
            //TODO: add blog to CloudKit
            saveToCK()
            
            blogPost.textColor = .black
            titleField.textColor = .black
            
            titleField.text = ""
            blogPost.text = "Blog Post..."
            blogImg.image = UIImage(named: "")
        }
    }
    
    func saveToCK() {
        //instantiate blog
        let blogRecord = CKRecord(recordType: "Blog")
        blogRecord["titleField"] = titleField.text! as CKRecordValue
        blogRecord["blogBody"] = blogPost.text! as __CKRecordObjCValue
        
        //try save
        CKContainer.default().publicCloudDatabase.save(blogRecord) { [unowned self]record, error in
            DispatchQueue.main.async {
                if let _ = error {
                    //error occurred while saving the blog
                    print("Error occurred while saving!")
                    self.view.backgroundColor = .red
                } else {
                    //saved the blog
                    print("Saved!")
                    self.view.backgroundColor = .green
                    
                    ContentCreatorFrameViewController.isDirty = true
                }
            }
        }
    }
    
    func photoLibrary() {
        image.sourceType = .photoLibrary
        image.allowsEditing = true
        
        present(image, animated: true, completion: nil)
    }
    
    func camera() {
        image.sourceType = .camera
        image.allowsEditing = true
        
        present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            blogImg.image = img
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
