//
//  TableViewCell2.swift
//  swift_pro
//
//  Created by Daniel on 04/01/2022.
//

import UIKit

class TableViewCell2: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var favButtonOut: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favButton(_ sender: Any) {
        
    }
}
