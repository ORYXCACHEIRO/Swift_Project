//
//  ArticleViewController.swift
//  swift_pro
//
//  Created by Daniel on 26/01/2022.
//

import UIKit
import CoreData

class ArticleViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var titleOut: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var summaryOut: UITextView!
    @IBOutlet weak var dateoUT: UILabel!
    @IBOutlet weak var buttonOut: UIButton!
    private var favorieItem : FavoriteArticles?
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(article)
        
        titleOut.text = article?.title
        summaryOut.text = article?.summary
        let dateee = (article?.publishedAt.prefix(10))!
        dateoUT.text = String(dateee)
        
        let url = URL(string: article?.imageUrl ?? "")!
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            img.image = UIImage(data: data)
            img.layer.cornerRadius = 6
        }
        
        getFavorites(id: article!.id)
         if(isFavorite==true){
             buttonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        } else {
            buttonOut.setImage(UIImage.init(systemName: "star"), for: .normal)
        }
        //titleOut.text = article.title
        // Do any additional setup after loading the view.
    }
    
    func getFavorites(id: Int){
        //print(id)
        let fetch = FavoriteArticles.fetchRequest() as NSFetchRequest<FavoriteArticles>
        let pred = NSPredicate(format: "id == \(id)")
        //print(pred)
        fetch.predicate = pred
        print(fetch)
        do{
            let data = try context.fetch(fetch)
            
            if(data.isEmpty==false){
                isFavorite = true
                favorieItem = data.first
            }
        }
        catch{
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
            buttonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
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
            buttonOut.setImage(UIImage.init(systemName: "star"), for: .normal)
            print("remove")
        }
        catch{
            print("erro remove")
        }
        
    }
    

    @IBAction func button(_ sender: UIButton) {
        //print(isFavorite)
        if(isFavorite==false){
            addFavorite()
            buttonOut.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
        } else {
            removeFavorite(article: favorieItem!)
            buttonOut.setImage(UIImage.init(systemName: "star"), for: .normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
