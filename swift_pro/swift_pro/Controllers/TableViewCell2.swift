//
//  TableViewCell2.swift
//  swift_pro
//
//  Created by Daniel on 04/01/2022.
//

import UIKit
import CoreData

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
    private var favorieItem : FavoriteArticles?
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var isFavorite: Bool = false
    var article : Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            getFavorites(id: article!.id)
            if(isFavorite==true){
                favButtonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
           } else {
               favButtonOut.setImage(UIImage.init(systemName: "star"), for: .normal)
           }
        }
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
    
    func getFavorites(id: Int){
        let fetch = FavoriteArticles.fetchRequest() as NSFetchRequest<FavoriteArticles>
        let pred = NSPredicate(format: "id == %i", id)
        fetch.predicate = pred
        do{
            let data = try context.fetch(fetch)
            
            
            if(data.isEmpty==false){
                //print(data[0].title)
                isFavorite = true
                favorieItem = data.first
                favButtonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
                print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
            }
        }
        catch {
           print("erro")
        }
    }
    
    
    func addFavorite(){
        //print(article)
        let newItem = FavoriteArticles(context: context)
        newItem.id = Int16(article!.id)
        newItem.title = article?.title
        newItem.newsSite = article?.newsSite
        newItem.imageUrl = article?.imageUrl
        newItem.summary = article?.summary
        newItem.publishedAt = (article?.publishedAt)!
        
        do{
            try context.save()
            isFavorite = true
            favorieItem = newItem
            favButtonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
            print("add")
        }
        catch{
            print("erro add")
        }

    }
    
    func removeFavorite(article: FavoriteArticles){
        context.delete(article)
        do{
            try context.save()
            isFavorite = false
            favButtonOut.setImage(UIImage.init(systemName: "star"), for: .normal)
            print("remove")
        }
        catch{
            print("erro remove")
        }
        
    }
    
    @IBAction func favButton(_ sender: UIButton) {
        if(isFavorite==false){
            addFavorite()
            favButtonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        } else {
            removeFavorite(article: favorieItem!)
            favButtonOut.setImage(UIImage.init(systemName: "star"), for: .normal)
        }
    }
}
