//
//  MushroomDetailViewController.swift
//  MushroomSpot
//
//  Created by Apple on 15/04/25.
//

import UIKit

class MushroomDetailViewController: UIViewController {
    
    var mushroom: Mushroom?
    @IBOutlet weak var latinNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let mushroom = mushroom else { return }

        nameLabel.text = mushroom.name
        latinNameLabel.text = mushroom.latin_name
        idLabel.text = "ID: \(mushroom.id)"

        if let url = URL(string: mushroom.profile_picture) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

    
