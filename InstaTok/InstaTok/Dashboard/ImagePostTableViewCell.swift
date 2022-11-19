//
//  ImagePostTableViewCell.swift
//  InstaTok
//
//  Created by 江一帆 on 11/18/22.
//

import UIKit

class ImagePostTableViewCell: UITableViewCell {

    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var caption: UILabel!
    
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
