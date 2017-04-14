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
        if Reachability.isConnectedToNetwork() == true
        {
            self.txtID.isEnabled = true
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "You are not connected to the Internet. An Internet connection is required to run this app. Please try again later", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.txtID.isEnabled = false
        }
        refreshTimerFunc()
    }
    
    var refreshTimer = Timer()
    
    func refreshTimerFunc(){
        refreshTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateData), userInfo: nil, repeats: true)
    }
    
    func updateData(){
        if Reachability.isConnectedToNetwork() == true
        {
            self.txtID.isEnabled = true
        }
        else {
            self.txtID.isEnabled = false
            let alert = UIAlertController(title: "Error", message: "You are not connected to the Internet. An Internet connection is required to run this app. Please try again later", preferredStyle: UIAlertControllerStyle.alert)
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
    }
    
    let lecPassword = "1995"
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
                segPicker.isHidden = true
            }
            if let t = txtID.text {
                ViewController.GlobalVariable.sessionID = t
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
    
    public class Reachability {
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }

            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
        }
    }

}

