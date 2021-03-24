//
//  AnimationViewController.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/23/21.
//

import UIKit

class AnimationViewController: ViewController {

    @IBOutlet weak var animButon: UIButton!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleButton(myButton)
        myButton.setImage(UIImage(named: "appLogo"), for: .normal)
        
        animate()
    }
    
    func animate() {
        UIButton.animate(withDuration: 2) {
            self.animButon.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            
        } completion: { (done) in
            if done {
                self.animButon.setImage(UIImage(named: "appLogo"), for: .normal)
                
                UIButton.animate(withDuration: 1) {
                    self.animButon.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
                    self.animButon.center = self.view.center
                } completion: { (done) in
                    if done {
                        self.animButon.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
                        self.animButon.center = self.view.center
                    }
                }
            }
        }
    }
}
