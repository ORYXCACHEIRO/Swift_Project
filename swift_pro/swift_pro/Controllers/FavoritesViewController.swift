//
//  FavoritesViewController.swift
//  swift_pro
//
//  Created by Daniel on 28/01/2022.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    private var viewModals = [CellViewModel]()
    private var articles = [Article]()
    var favs : [FavoriteArticles]?
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var tableOut: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "newsCell2")
        tableOut.delegate = self
        tableOut.dataSource = self
        tableOut.refreshControl = UIRefreshControl()
        tableOut.refreshControl?.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        // Do any additional setup after loading the view.
        
        
        getFavs()
        
    }
    
    @objc func pullRefresh(){
        self.getFavs()
    }
    
    func getFavs(){
        do{
            self.favs = try context.fetch(FavoriteArticles.fetchRequest())
            
            favs?.forEach { item in
                let articleee = Article(id: Int(item.id), title: item.title!, imageUrl: item.imageUrl!, newsSite: item.newsSite!, summary: item.summary!, publishedAt: String(item.publishedAt!.prefix(10)))
                
                self.articles.append(articleee)
            }
            
            self.viewModals = (favs?.compactMap({
                CellViewModel(id: Int($0.id), title: $0.title!, imageUrl: $0.imageUrl!, newsSite: $0.newsSite!, publishedAt: String($0.publishedAt!.prefix(10)))
            }))!
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.tableOut.refreshControl?.endRefreshing()
                self.tableOut.reloadData()
            }
                
            
        }catch{
            print("erro")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        //let vc = ArticleViewController(article: article)
        //print(articles[ (tableOut.indexPathForSelectedRow?.row)!])
        performSegue(withIdentifier: "favItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //let article = articles[indexPath.row]
        if let destination = segue.destination as? ArticleViewController{
            destination.article = articles[ (tableOut.indexPathForSelectedRow?.row)!]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell2", for: indexPath) as! TableViewCell2

        cell.article = articles[indexPath.row]
        cell.configure(with: viewModals[indexPath.row])
        
        return cell
    }

}
