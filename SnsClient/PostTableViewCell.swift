//
//  PostTableViewCell.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/19.
//

import UIKit
import Instantiate
import InstantiateStandard

class PostTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
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
