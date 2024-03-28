//
//  VolunteeringTableViewCell.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 28.03.2024.
//

import UIKit

class VolunteeringTableViewCell: UITableViewCell {

    @IBOutlet weak var organizationImage: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
