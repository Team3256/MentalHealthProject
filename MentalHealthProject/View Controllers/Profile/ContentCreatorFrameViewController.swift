//
//  ContentCreatorFrameViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/1/21.
//

import UIKit

class ContentCreatorFrameViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var blogImg: UIImageView!
    
    private let image = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.delegate = self
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
