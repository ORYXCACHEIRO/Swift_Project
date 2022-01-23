//
//  NewsTableController.swift
//  swift_pro
//
//  Created by ci on 21/12/2021.
//

// seguir este exemplo
//https://levelup.gitconnected.com/getting-started-with-uitableview-in-swift-9b04e6fd8b9a

//https://medium.com/@nutanbhogendrasharma/consume-rest-api-in-swiftui-ios-mobile-app-b3c5d6ecf401

import UIKit


class NewsTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var viewModals = [CellViewModel]()

    @IBOutlet weak var tableOut: UITableView!
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.delegate = self
        tableOut.dataSource = self
        // Do any additional setup after loading the view.
        
        tableOut.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "newsCell2")
        API.shared.getStories{ [weak self] result in
            switch result{
            case .success(let result):
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
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

}
