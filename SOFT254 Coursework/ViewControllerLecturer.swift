//
//  ViewControllerLecturer.swift
//  SOFT254 Coursework
//
//  Created by (s) Christopher Dyson on 31/03/2017.
//  Copyright © 2017 (s) Christopher Dyson. All rights reserved.
//

import UIKit

class ViewControllerLecturer: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        sessionID = ViewController.GlobalVariable.sessionID
        navigationbar.title = "\(sessionID)"
        loadJSON()
        refreshTimerFunc()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var navigationbar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnMarkComplete(_ sender: Any) {
        markOneAsComplete()
    }
    @IBAction func btnStopSession(_ sender: Any) {
        refreshTimer.invalidate()
        markAllAsComplete()
    }
    @IBOutlet weak var lblLecTitle: UILabel!
    var sessionID : String = ""
    var myArray : [String] = ["Loading..."]
    var refreshTimer = Timer()
    
    func refreshTimerFunc(){
        refreshTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.updateData), userInfo: nil, repeats: true)
    }
    
    func updateData(){
        self.tableView.deselectSelectedRow(animated: true)
        loadJSON()
    }
    
    func loadJSON() {
        self.myArray = []
        let url = URL(string: "http://46.32.240.33/ios.cdysonplym.co.uk/viewall.php?sid=\(sessionID)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                var i = 0
                var j = String(i)
                var b = true
                
                while (b == true) {
                    let query = json[j]
                    if let q = query {
                        self.myArray.append(String(describing:q))
                        i = i + 1
                        j = String(i)
                    }
                    else {
                        b = false
                    }
                }

                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    func markOneAsComplete() {
        let url = URL(string: "http://46.32.240.33/ios.cdysonplym.co.uk/deletesingle.php?sid=\(sessionID)&name=\(selectedString)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            self.loadJSON()
        }).resume()
    }

    func markAllAsComplete() {
        let url = URL(string: "http://46.32.240.33/ios.cdysonplym.co.uk/deleteall.php?sid=\(sessionID)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            self.loadJSON()
        }).resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = self.myArray[indexPath.row]
        return cell
    }
    
    var selectedString = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedString = self.myArray[indexPath.row]
        selectedString = selectedString.replacingOccurrences(of: " ", with: "%20")
    }

}

extension UITableView {
    public func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow
        {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}
