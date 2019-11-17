//
//  NewViewController.swift
//  QiitAPI
//
//  Created by Syun Tanaka on 2019/11/14.
//  Copyright © 2019 Syun Tanaka. All rights reserved.
//

import UIKit
import WebKit

class NewViewController: UIViewController {
    
    var testString = ""
    
    @IBOutlet weak var qiitaWeb: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: testString) {
            let request = NSURLRequest(url: url as URL)
            qiitaWeb.load(request as URLRequest)
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
