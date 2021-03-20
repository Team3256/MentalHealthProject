//
//  GymCell.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit

class GymCell: UITableViewCell {
    static let identifier = "GymCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(_ name: String, _ num: String) {
        nameLabel.text = name
        numLabel.text = num
        
        self.accessoryType = .detailButton
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
