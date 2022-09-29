//
//  TouristCell.swift
//  Tourist App
//
//  Created by 江一帆 on 9/28/22.
//

import UIKit

class TouristCell: UITableViewCell {

    @IBOutlet weak var lblTourist: UILabel!
    @IBOutlet weak var imgTourist: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
