//
//  ArticleViewController.swift
//  swift_pro
//
//  Created by Daniel on 26/01/2022.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var titleOut: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var summaryOut: UITextView!
    @IBOutlet weak var dateoUT: UILabel!
    
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
        //titleOut.text = article.title
        // Do any additional setup after loading the view.
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
