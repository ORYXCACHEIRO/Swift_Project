//
//  NewsTableController.swift
//  swift_pro
//
//  Created by ci on 21/12/2021.
//

// seguir este exemplo
//https://levelup.gitconnected.com/getting-started-with-uitableview-in-swift-9b04e6fd8b9a

import UIKit

class NewsTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var name = ["Johnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn", "Mike", "Adam", "Ricky", "Helen"]
    let url = URL(string: "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg")!

    @IBOutlet weak var tableOut: UITableView!
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.delegate = self
        tableOut.dataSource = self
        // Do any additional setup after loading the view.
        
        tableOut.register(UINib(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "newsCell2")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell2", for: indexPath) as! TableViewCell2
        
        cell.title.text = name[indexPath.row]
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            cell.img.image = UIImage(data: data)
        }
        
        return cell
    }

}
