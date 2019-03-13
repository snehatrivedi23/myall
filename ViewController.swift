//
//  ViewController.swift
//  AlamofireWithDataBase
//
//  Created by Sagar Somaiya on 13/03/19.
//  Copyright © 2019 Sagar Somaiya. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewList: UITableView!
    var arrayUser : [[String:Any]] = []
    var filteredData: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewList.register(UINib(nibName: AllTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllTableViewCell.identifier)
        self.tableViewList.rowHeight = UITableView.automaticDimension
        self.tableViewList.estimatedRowHeight = 100
        self.tableViewList.tableFooterView = UIView(frame: CGRect.zero)
       let delete = "DELETE FROM STUDENT"
       Database.share()?.delete(delete)
       self.getDataFromapi()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getDataFromapi(){
        let parameters  : [String:Any] = [:]
        let urlPost =  "http://www.mocky.io/v2/5c87c3bb32000069103bd4a2"
        //urlPost request
        Alamofire.request(urlPost, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            print(response)
            if let responseDict = response.result.value{
                let json = JSON(responseDict)
                print(json)
                let dict = responseDict as? NSDictionary
                print(dict as Any)
                
                for (key,value) in (dict)! {
                    print(key)
                    print(value)
                    let first = key as! String
                    print(first)
                    if first != "result" {
                        self.arrayUser.append(value as! [String : Any])
                     }
                }
                for object in self.arrayUser {
                    print(object["first_name"] as Any)
                    let queryinsert: String = "INSERT INTO STUDENT(Name,Semester) VALUES(\'\(object["first_name"]!)\',\'\(object["last_name"]!)\')"
                    print(queryinsert)
                    Database.share().insert(queryinsert)
                }
                let select:String = "SELECT * FROM STUDENT"
                self.filteredData = Database.share().selectAll(fromTable: select) as! [[String : Any]]
                print(self.filteredData)
                print(self.arrayUser.count)
                self.arrayUser = self.filteredData
                self.tableViewList.delegate = self
                self.tableViewList.dataSource = self
                self.tableViewList.reloadData()
            }
            
        }
    }
            
}
extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewList.dequeueReusableCell(withIdentifier: AllTableViewCell.identifier, for: indexPath) as! AllTableViewCell
        //for urlget1 and urlpost
         cell.labelFirstName.text = self.filteredData[indexPath.row]["Name"] as? String
         cell.labelLastName.text = self.filteredData[indexPath.row]["Semester"] as? String
        // cell.imageUser.sd_setImage(with: URL(string: (self.arrayUser[indexPath.row]["avatar"] as? String)!), completed: nil)
       
        return cell
        
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.objData = self.filteredData[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            self.filteredData.remove(at: indexPath.row)
            tableViewList.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredData = arrayUser
        } else {
            filteredData.removeAll()
            //            let searchPredicate = NSPredicate(format: "first_name like %@", searchText)
            //            let array = (self.arrayUser as NSArray).filtered(using: searchPredicate)
            let array = self.arrayUser.filter { ($0["Name"] as! String).range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil }
            self.filteredData = array
        }
        
        self.tableViewList.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filteredData = arrayUser
        self.tableViewList.reloadData()
    }
}
