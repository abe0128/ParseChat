//
//  ChatCell.swift
//  ParseChat
//
//  Created by Abraham De Alba on 10/23/18.
//  Copyright © 2018 Abraham De Alba. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
