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

    var name = ["John", "Mike", "Adam", "Ricky", "Helen"]

    @IBOutlet weak var tableOut: UITableView!
    
    // MARK: - Table view data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOut.delegate = self
        tableOut.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! TableViewCell
        
        cell.textLabel?.text = name[indexPath.row]
        return cell
    }

}
