//
//  ExperienceTableViewCell.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var experienceImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
