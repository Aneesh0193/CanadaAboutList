//
//  AboutTableViewCell.swift
//  Canada
//
//  Created by user on 16/02/24.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionsLabel: UILabel!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
