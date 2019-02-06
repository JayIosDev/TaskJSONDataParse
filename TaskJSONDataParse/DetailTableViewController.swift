//
//  DetailTableViewController.swift
//  TaskJSONDataParse
//
//  Created by Diya Kasliwal on 21/12/18.
//  Copyright © 2018 Diya Kasliwal. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var userArray = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchingJsonDataFromServer()
     
        }

    

    
        



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell

        
        
        let data = self.userArray["data"] as? [String:Any]
        //  print(data)
        let secdata = data?["associations"] as? [[String:Any]]
        
       // let usersDictionary = fullDataModel![indexPath.row]


        cell.label1.text = secdata?[indexPath.row]["Email"] as? String
       
        
        cell.label2.text = secdata?[indexPath.row]["PANNo"] as? String
        
        
        cell.label3.text = secdata?[indexPath.row]["Name"] as? String
        cell.label4.text = secdata?[indexPath.row]["Country"] as? String
        
        let units = secdata?[indexPath.row]["TotalUnits"] as? Int
        
        cell.label5.text = String(format: "%d", units ?? "test")
        
        
        cell.label6.text = secdata?[indexPath.row]["ManagerName"] as? String

        let mobile = secdata?[indexPath.row]["ManagerMobile"] as? Int
        
        cell.label7.text = String(format: "%ld", mobile ?? "test")
        

        return cell
    }
    

    func fetchingJsonDataFromServer(){
        
        let urlStr = String(format: "http://www.json-generator.com/api/json/get/bTKaWyzyJK?indent=2")
        var request =  URLRequest(url: URL(string: urlStr)!)
        request.httpMethod="GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler:
        {
            (data:Data?,response:URLResponse?,error:Error?)->Void
            in
            if(error==nil)
            {
                DispatchQueue.main.async {
                    do
                    {
                        try self.userArray = JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                       
                      
                   //     print(self.userArray)
                        
                        let data = self.userArray["data"] as? [String:Any]
                      //  print(data)
                        let secdata = data?["associations"] as? [[String:Any]]
                        
                        print(secdata)
                        
                    }
                    catch
                    {
                        print("error \(error)")
                    }
                }
            }
        })
        task.resume();
    }

    
    
    
    
    
    
    

}
