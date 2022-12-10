//
//  TestTableViewCell.swift
//  test
//
//  Created by 江一帆 on 12/10/22.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
