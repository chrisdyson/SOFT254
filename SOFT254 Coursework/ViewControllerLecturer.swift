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
        loadJSON()
        scheduledTimerWithTimeInterval()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnMarkComplete(_ sender: Any) {
    }
    @IBAction func btnStopSession(_ sender: Any) {
        timer.invalidate()
    }
    @IBOutlet weak var lblLecTitle: UILabel!
    var myArray : [String] = []
    var timer = Timer()
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
        //timer.invalidate   to stop timer
    }
    var i = 0
    func updateCounting(){
        NSLog("counting..")
        print("stuff")
        i = i + 1
        lblLecTitle.text = String(i)
    }
    
    func loadJSON() {
        let url = URL(string: "http://46.32.240.33/ios.cdysonplym.co.uk/admin.php")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                
                var query = json["0"]
                if let q = query {
                    self.myArray.append(String(describing:q))
                }
                query = json["1"]
                if let q = query {
                    self.myArray.append(String(describing:q))
                }
                query = json["2"]
                if let q = query {
                    self.myArray.append(String(describing:q))
                }
                query = json["3"]
                if let q = query {
                    self.myArray.append(String(describing:q))
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            } catch let error as NSError {
                print(error)
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedString = self.myArray[indexPath.row]
        print("You picked \(selectedString)")
    }
    
}
