//
//  ViewControllerWeb.swift
//  SOFT254 Coursework
//
//  Created by Chris on 06/05/2017.
//  Copyright © 2017 (s) Christopher Dyson. All rights reserved.
//

import UIKit

class ViewControllerWeb: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: ViewController.GlobalVariable.url + "viewhistory.php") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
