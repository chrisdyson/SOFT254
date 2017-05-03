//
//  ViewControllerStudent.swift
//  SOFT254 Coursework
//
//  Created by (s) Christopher Dyson on 31/03/2017.
//  Copyright © 2017 (s) Christopher Dyson. All rights reserved.
//

import UIKit

class ViewControllerStudent: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        sessionID = ViewController.GlobalVariable.sessionID
        navigationbar.title = "\(sessionID)"
        self.txtName.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        refreshInternetTimerFunc()
    }
    
    var refreshInternetTimer = Timer()
    
    func refreshInternetTimerFunc(){
        refreshInternetTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateInternetData), userInfo: nil, repeats: true)
    }
    
    func updateInternetData(){
        if Reachability.isConnectedToNetwork() == true {
            self.txtName.isEnabled = true
        }
        else {
            self.txtName.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnAddToQ: UIButton!
    @IBAction func btnAddToQ(_ sender: Any) {
        if let t = txtName.text, !t.isEmpty {
            addToQueue(name: t)
            let alert = UIAlertController(title: "Success", message: "Added to queue, \(sessionID)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            txtName.text = ""
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Name cannot be blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var navigationbar: UINavigationItem!
    var sessionID : String = ""
    
    func addToQueue(name: String) {
        let newName = name.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: ViewController.GlobalVariable.url + "addsingle.php?sid=\(sessionID)&name=\(newName)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
        }).resume()
    }
    
}
