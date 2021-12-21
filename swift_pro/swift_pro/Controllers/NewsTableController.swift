//
//  NewsTableController.swift
//  swift_pro
//
//  Created by ci on 21/12/2021.
//

// seguir este exemplo
//https://levelup.gitconnected.com/getting-started-with-uitableview-in-swift-9b04e6fd8b9a

import UIKit

struct Article {
    var title: String
    var details: String
    var image: String
}

class NewsTableController: ViewController, UITableViewDelegate, UITableViewDataSource {

    let articles = [
        Article(title: "Noticia", details: "Austria", image: "https://cdn.ralfebert.de/static_table_contents-719d31f2.png"),
        Article(title: "Noticia", details: "Belgium", image: "https://cdn.ralfebert.de/static_table_contents-719d31f2.png"),
        Article(title: "Noticia", details: "Germany", image: "https://cdn.ralfebert.de/static_table_contents-719d31f2.png"),
        Article(title: "Noticia", details: "Greece", image: "https://cdn.ralfebert.de/static_table_contents-719d31f2.png"),
        Article(title: "Noticia", details: "France", image: "https://cdn.ralfebert.de/static_table_contents-719d31f2.png"),
    ]

    @IBOutlet weak var tableOut: UITableView!
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.delegate = self
        tableOut.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

}
