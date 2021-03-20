//
//  RevCell.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/19/21.
//

import UIKit

class RevCell: UITableViewCell {
    static let identifier = "RevCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(_ name: String, _ rate: Int) {
        nameLabel.text = name
        ratingLabel.text = "\(rate)/5"
        
        self.accessoryType = .disclosureIndicator
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
