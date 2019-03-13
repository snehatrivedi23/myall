//
//  DetailViewController.swift
//  AlamofireWithDataBase
//
//  Created by Sagar Somaiya on 13/03/19.
//  Copyright © 2019 Sagar Somaiya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var objData : [String:Any] = [:]
    
    @IBOutlet weak var clickBack: UIButton!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLName: UILabel!
    @IBOutlet weak var labelid: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelAddreess: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelName.text = objData["Name"] as? String
        self.labelLName.text = objData["Semester"] as? String
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BtnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
