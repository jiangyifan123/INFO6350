//
//  WeatherTableViewCell.swift
//  Weather forecast
//
//  Created by 江一帆 on 11/19/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperature: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
