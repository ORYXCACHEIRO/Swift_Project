//
//  TableViewCell2.swift
//  swift_pro
//
//  Created by Daniel on 04/01/2022.
//

import UIKit

class CellViewModel {
    let id: Int
    let title: String
    let imageUrl: String
    let newsSite: String
    let publishedAt: String
    
    init(
        id: Int,
        title: String,
        imageUrl: String,
        newsSite: String,
        publishedAt: String
    ) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.newsSite = newsSite
        self.publishedAt = publishedAt
    }
    
}


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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: CellViewModel){
        title.text = viewModel.title
        date.text = viewModel.publishedAt
        
        
        let url = URL(string: viewModel.imageUrl)!
        
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            img.image = UIImage(data: data)
            img.layer.cornerRadius = 6
        }
    }
    
    @IBAction func favButton(_ sender: Any) {
        
    }
}
