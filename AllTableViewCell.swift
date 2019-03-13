//
//  AllTableViewCell.swift
//  AlamofireWithDataBase
//
//  Created by Sagar Somaiya on 13/03/19.
//  Copyright © 2019 Sagar Somaiya. All rights reserved.
//

import UIKit

class AllTableViewCell: UITableViewCell {
    static let identifier = String(describing: AllTableViewCell.self)
    
    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         imageUser.layer.cornerRadius = imageUser.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
