//
//  ViewController.swift
//  SOFT254 Coursework
//
//  Created by (s) Christopher Dyson on 20/03/2017.
//  Copyright © 2017 (s) Christopher Dyson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.txtName.delegate = self
        self.txtPassword.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    let lecPassword = "1995"
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var segPicker: UISegmentedControl!
    @IBOutlet weak var btnGoToLecturer: UIButton!
    @IBOutlet weak var btnGoToStudent: UIButton!
    
    @IBAction func segPicker(_ sender: Any) {
        switch (segPicker.selectedSegmentIndex) {
            case 0:
            lblPassword.isHidden = false;
            txtPassword.isHidden = false;
            //btnGoToLecturer.isHidden = false;
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
        if (txtPassword.text != lecPassword) {
            btnGoToLecturer.isHidden = true;
            let myColour : UIColor = UIColor.red
            txtPassword.layer.borderColor = myColour.cgColor
            txtPassword.layer.borderWidth = 1.0
            txtPassword.layer.cornerRadius = 5
        }
        else {
            btnGoToLecturer.isHidden = false;
            let myColour : UIColor = UIColor.green
            txtPassword.layer.borderColor = myColour.cgColor
            txtPassword.layer.borderWidth = 1.0
            txtPassword.layer.cornerRadius = 5
        }
    }


}

