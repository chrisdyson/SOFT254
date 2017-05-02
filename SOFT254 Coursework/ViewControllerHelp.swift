//
//  ViewControllerHelp.swift
//  SOFT254 Coursework
//
//  Created by Chris on 01/05/2017.
//  Copyright © 2017 (s) Christopher Dyson. All rights reserved.
//

import UIKit

class ViewControllerHelp: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtHome.layer.borderWidth = 1
        txtStudent.layer.borderWidth = 1
        txtLecturer.layer.borderWidth = 1
        txtHome.layer.cornerRadius = 5
        txtStudent.layer.cornerRadius = 5
        txtLecturer.layer.cornerRadius = 5
        txtHome.layer.borderColor = UIColor(red:0.0, green:122.0/255.0, blue:1.0, alpha: 1.0).cgColor
        txtStudent.layer.borderColor = UIColor(red:0.0, green:122.0/255.0, blue:1.0, alpha: 1.0).cgColor
        txtLecturer.layer.borderColor = UIColor(red:0.0, green:122.0/255.0, blue:1.0, alpha: 1.0).cgColor
        txtHome.textContainerInset = UIEdgeInsetsMake(20,20,20,20);
        txtStudent.textContainerInset = UIEdgeInsetsMake(20,20,20,20);
        txtLecturer.textContainerInset = UIEdgeInsetsMake(20,20,20,20);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var segWhich: UISegmentedControl!
    @IBOutlet weak var txtHome: UITextView!
    @IBOutlet weak var txtStudent: UITextView!
    @IBOutlet weak var txtLecturer: UITextView!

    @IBAction func segWhich(_ sender: Any) {
        switch (segWhich.selectedSegmentIndex) {
        case 0:
            txtHome.isHidden = false;
            txtStudent.isHidden = true;
            txtLecturer.isHidden = true;
        case 1:
            txtHome.isHidden = true;
            txtStudent.isHidden = false;
            txtLecturer.isHidden = true;
        case 2:
            txtHome.isHidden = true;
            txtStudent.isHidden = true;
            txtLecturer.isHidden = false;
        default:
            print ("Error")
        }
    }

    
}
