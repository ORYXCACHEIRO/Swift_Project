//
//  NewsTableController.swift
//  swift_pro
//
//  Created by ci on 21/12/2021.
//

import UIKit


class NewsTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var viewModals = [CellViewModel]()
    private var articles = [Article]()

    @IBOutlet weak var tableOut: UITableView!
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "newsCell2")
        tableOut.delegate = self
        tableOut.dataSource = self
        tableOut.refreshControl = UIRefreshControl()
        tableOut.refreshControl?.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        // Do any additional setup after loading the view.
        
        getItems()
        
    }
    
    @objc func pullRefresh(){
        self.getItems()
    }
    
    func getItems(){
        API.shared.getStories{ [weak self] result in
            switch result{
            case .success(let result):
                result.forEach { item in
                    self?.articles.append(item)
                }
                self?.viewModals = result.compactMap({
                    CellViewModel(id: $0.id, title: $0.title, imageUrl: $0.imageUrl, newsSite: $0.newsSite, publishedAt: String($0.publishedAt.prefix(10)))
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.tableOut.refreshControl?.endRefreshing()
                    self?.tableOut.reloadData()
                }
                break
            case .failure(let error):
                print (error)
                break
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        //let vc = ArticleViewController(article: article)
        //print(articles[ (tableOut.indexPathForSelectedRow?.row)!])
        performSegue(withIdentifier: "articleDet", sender: self)
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
        
        //print(articles[indexPath.row])
        cell.article = articles[indexPath.row]
        cell.configure(with: viewModals[indexPath.row])
        
        return cell
    }

}
