//
//  SearchViewController.swift
//  swift_pro
//
//  Created by Daniel on 25/01/2022.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    
    private var viewModals = [CellViewModel]()
    private var articles = [Article]()

    @IBOutlet weak var tableOut: UITableView!
    
    @IBOutlet weak var searchOut: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.delegate = self
        tableOut.dataSource = self
        searchOut.delegate = self
        // Do any additional setup after loading the view.
        
        tableOut.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "newsCell2")
        
        // Do any additional setup after loading the view.
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        API.shared.searchArticles(with: searchOut.text!) { [weak self] result in
            switch result{
            case .success(let result):
                result.forEach { item in
                    self?.articles.append(item)
                }
                self?.viewModals = result.compactMap({
                    CellViewModel(id: $0.id, title: $0.title, imageUrl: $0.imageUrl, newsSite: $0.newsSite, publishedAt: String($0.publishedAt.prefix(10)))
                })
                DispatchQueue.main.async {
                    self?.tableOut.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
        print(searchOut.text!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        //let vc = ArticleViewController(article: article)
        print(articles[ (tableOut.indexPathForSelectedRow?.row)!])
        performSegue(withIdentifier: "articleRes", sender: self)
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
        
        cell.configure(with: viewModals[indexPath.row])
        
        //if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            //cell.img.image = UIImage(data: data)
            //cell.img.layer.cornerRadius = 6
        //}
        
        return cell
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
