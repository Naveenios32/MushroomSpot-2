//
//  MushroomCell.swift
//  MushroomSpot
//
//  Created by Apple on 15/04/25.
//

import UIKit

class MushroomCell: UITableViewCell {
    
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mushroomImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
