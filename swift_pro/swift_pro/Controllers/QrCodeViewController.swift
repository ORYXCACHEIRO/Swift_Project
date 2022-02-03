//
//  QrCodeViewController.swift
//  swift_pro
//
//  Created by Daniel Faria on 03/02/2022.
//

import UIKit

class QrCodeViewController: UIViewController {
    
    var qrcode:String?

    @IBOutlet weak var imageOut: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.qrserver.com/v1/create-qr-code/?data=\(qrcode ?? "")&size=1000x1000")!
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            imageOut.image = UIImage(data: data)
        }
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
