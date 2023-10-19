//
//  ProfileTableViewCell.swift
//  day2
//
//  Created by ATM Touchpoint on 13/10/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValue (type: ProfileType, value: String){
        titleLabel.text = type.rawValue
        descriptionLabel.text = value
        
        if type == ProfileType.bio {
            descriptionLabel.numberOfLines = 0
        }else{
            descriptionLabel.numberOfLines = 1
        }
    }
    
}
