//
//  CustomTableViewController.swift
//  Homework2
//
//  Created by Vinnakota, Venkata Ratna Ushaswini on 10/6/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class CustomTableViewController: UITableViewController {
    
    let UrlToDownloadData = "http://dev.theappsdr.com/apis/summer_2016_ios/data.json"
    
    private var dataToTable = [String : Array<RowCell>]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //download list
        DownloadData()
        //auto adjust the height of row
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension      
    }

    func DownloadData (){
        
        //alamofire is expected to run asynchronously.
        Alamofire.request(
            URL(string:UrlToDownloadData)!,
            method: .get)
            .validate()
            .responseJSON{
                (response) -> Void in
                               
                if let jsonDict = response.result.value as? [String:Any],
                    let dataArray = jsonDict["feed"] as? [[String:Any]] {
                    let rows = dataArray.flatMap { (item) ->RowCell? in
                        return RowCell(json: item)
                    }
                    
                    self.seperateDataIntoSections(rows)
                    //print(rows)
                }
        }
        
    }
    
    func seperateDataIntoSections(_ data:[RowCell]){
        
        for cell in data {
            
            //If category is  present already, append to data
            if var val = dataToTable[cell.category]{
                val.append(cell)
                dataToTable[cell.category] = val
            }else{
                //create a new key
                dataToTable[cell.category]=[cell]
            }
        }
        //sorting the sections in alphabetical order
        let sortedKeyDict = dataToTable.sorted(by: { $0.0 < $1.0 })
        dataToTable.removeAll()
        for(k,v) in sortedKeyDict{
            dataToTable[k] = v
        }
        tableView.reloadData()
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataToTable.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = dataToTable[Array(dataToTable.keys)[section]]?.count
        return (count)!
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let data = dataToTable[Array(dataToTable.keys)[indexPath.section]]![indexPath.row]
        
        if data.otherImage != nil{
            if data.summary != nil{
               let cell = tableView.dequeueReusableCell(withIdentifier: "NoImageNoSummaryCell", for: indexPath) as! NoImageNoSummaryCell
                cell.data = data
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "WithImageNoSummaryCell", for: indexPath) as! WithImageNoSummaryCell
                cell.data = data
                return cell
            }
        }else{
            if data.summary != nil{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoImageWithSummaryCell", for: indexPath) as! NoImageWithSummaryCell
                cell.data = data
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoImageNoSummaryCell", for: indexPath) as! NoImageNoSummaryCell
                cell.data = data
                return cell
            }
        }
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        return Array(dataToTable.keys)[section]
        
    }
}
