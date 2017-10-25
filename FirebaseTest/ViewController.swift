//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Jill on 2017/10/12.
//  Copyright © 2017年 Jill. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var newPeopleName: UITextField!
    var ref: DatabaseReference!
    
    var peopleCount = 0
    var peopleName: Dictionary<String, String> = [:]
    var lastNameCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPeopleTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //        新增
    @IBAction func newPeople(_ sender: Any) {
        //        creat，會把原本的全部用掉
        //        self.ref.setValue(["name3": "Enieen"])
        //        self.ref.child("people").setValue(["name1": "Willie"])

        if (newPeopleName.text != nil && newPeopleName.text != ""){
            self.ref.child("people/name\(self.lastNameCount+1)").setValue(newPeopleName.text)
        }
        self.newPeopleName.text = nil
        self.getPeopleTable()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: peopleCell = tableView.dequeueReusableCell(withIdentifier: "tableCellIdentity", for: indexPath) as! peopleCell
        cell.nameLabel.text = Array(self.peopleName.values)[indexPath.row]
        cell.clickClosure = {
//            都是刪除
//            self.ref.child("people/\(Array(self.peopleName.keys)[indexPath.row])").setValue(nil)
            self.ref.child("people/\(Array(self.peopleName.keys)[indexPath.row])").removeValue()
            self.getPeopleTable()
        }
        
        return cell
    }
    
    @IBAction func refreshTable(_ sender: Any) {
        getPeopleTable()
    }
    
    func getPeopleTable() {
        ref = Database.database().reference()
        
        ref.child("people").observeSingleEvent(of: .value, with: { (snapshot) in
            self.peopleCount = Int(snapshot.childrenCount)
            // Get user value
            self.peopleName.removeAll()
            
            self.peopleName = snapshot.value as! Dictionary<String, String>
            
            //            取出最後一個數字，用在新增的時候
            let tmpStr = self.peopleName.keys.sorted(by: { firstKey, secondKey in
                let key1 = Int((firstKey as NSString).substring(from: 4))
                let key2 = Int((secondKey as NSString).substring(from: 4))
                return key1! < key2! // 由小到大排序
            }).last
            self.lastNameCount = Int((tmpStr! as NSString).substring(from: 4))!
            
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

