//
//  ViewController.swift
//  SOFT254 Coursework
//
//  Created by (s) Christopher Dyson on 20/03/2017.
//  Copyright © 2017 (s) Christopher Dyson. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtID.delegate = self
        self.txtPassword.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        refreshTimerFunc()
    }
    
    var refreshTimer = Timer()
    
    func refreshTimerFunc(){
        refreshTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(self.updateData), userInfo: nil, repeats: true)
    }
    
    func updateData(){
        if Reachability.isConnectedToNetwork() == true
        {
            self.txtID.isEnabled = true
            getPassword()
        }
        else {
            self.txtID.isEnabled = false
            let alert = UIAlertController(title: "Error!", message: "You are not connected to the Internet. An Internet connection is required to run this app. Please try again later", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    
    struct GlobalVariable{
        static var sessionID = "0000"
        static var url = "http://46.32.240.33/ios.cdysonplym.co.uk/"
    }
    
    func getPassword() {
        let url = URL(string: GlobalVariable.url + "lecturerpassword.txt")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                self.lecPassword = json["Password"] as! String
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    var lecPassword = ""
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var segPicker: UISegmentedControl!
    @IBOutlet weak var btnGoToLecturer: UIButton!
    @IBOutlet weak var btnGoToStudent: UIButton!
    
    @IBAction func btnStu(_ sender: Any) {
        resetOnBack()
    }
    @IBAction func btnLec(_ sender: Any) {
        resetOnBack()
    }
    
    @IBAction func segPicker(_ sender: Any) {
        switch (segPicker.selectedSegmentIndex) {
        case 0:
            lblPassword.isHidden = false;
            txtPassword.isHidden = false;
            btnGoToStudent.isHidden = true;
        case 1:
            lblPassword.isHidden = true;
            txtPassword.isHidden = true;
            btnGoToLecturer.isHidden = true;
            btnGoToStudent.isHidden = false;
        default:
            print ("Error")
        }
        dismissKeyboard()
    }
   
    @IBAction func textFieldChanged(_ sender: UITextField) {
        switch (sender) {
        case txtPassword:
            if (txtPassword.text != lecPassword) {
                btnGoToLecturer.isHidden = true
            }
            else {
                btnGoToLecturer.isHidden = false;
            }
        default:
            print ("Error")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        switch (textField) {
        case txtID:
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        default:
            print ("Error")
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch (textField) {
        case txtID:
            if let t = txtID.text, !t.isEmpty {
                segPicker.isHidden = false
            }
            else {
                resetOnBack()
            }
            if let t = txtID.text {
                ViewController.GlobalVariable.sessionID = t
            }
        case txtPassword:
            if let t = txtPassword.text, t.isEmpty {
                btnGoToLecturer.isHidden = true
            }
            else {
                btnGoToLecturer.isHidden = false
            }
        default:
            print ("Error")
        }
    }
 
    func resetOnBack() {
        txtID.text = ""
        txtPassword.text = ""
        btnGoToStudent.isHidden = true
        btnGoToLecturer.isHidden = true
        lblPassword.isHidden = true
        txtPassword.isHidden = true
        segPicker.selectedSegmentIndex = -1
        segPicker.isHidden = true
        txtID.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }

}

