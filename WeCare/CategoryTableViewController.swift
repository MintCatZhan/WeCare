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
            category = Category(name: "Compensation", image: "money")
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .automatic)


        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = segues[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
