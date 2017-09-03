//
//  CategoryTableViewController.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 16/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CategoryTableViewController: UITableViewController {
    var allCategory = [Category]()
    var segues = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segues = ["minimumwage", "workinghours", "compensation", "visaprotections", "taxandsuperannuation", "unpaidtrials", "taxfilenumber", "taxandsuperannuationclaim", "workprotection", "awardsoragreements"]
        
        if allCategory.count == 0 {
            var category = Category(name: "Minimum Wage", image: "salary")
            allCategory.append(category)
            category = Category(name: "Working Hour", image: "time_full")
            allCategory.append(category)
            category = Category(name: "Insurance", image: "money")
            allCategory.append(category)
            category = Category(name: "Visa Protection", image: "visa")
            allCategory.append(category)
            category = Category(name: "Tax & Superannuation", image: "tax")
            allCategory.append(category)
            category = Category(name: "Unpaid Trials", image: "trail")
            allCategory.append(category)
            category = Category(name: "Tax File Number", image: "taxNumber")
            allCategory.append(category)
            category = Category(name: "Tax & Superannuation Claim", image: "claim")
            allCategory.append(category)
            category = Category(name: "Workplace Protection", image: "workplace")
            allCategory.append(category)
            category = Category(name: "Awards or Agreements", image: "award")
            allCategory.append(category)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.allCategory.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category: Category = self.allCategory[indexPath.row]
        cell.nameCategoryLabel.text = category.name
        cell.imageCategoryView.image = UIImage(named: category.image!)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = segues[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

}
