//
//  TrackerViewController.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 28/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //Mark: - UI Initialization
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var recordTableView: UITableView!
    //Mark: - Tracking Array Initialization
    var tracking = [HoursTracking]()
    
    //MARK: - Time initializarion
    var dateTimeHandler = DateTimeHandler()
    var timer = Timer()
    var hour: Int = 0
    var min: Int = 0
    var second: Int = 0
    var miliSecond : Int = 0
    var diffSec: Double = 0.0
    var startStopTimer: Bool = true
    var fromDate: String = ""
    var toDate: String = ""
    
    //Store String

    var savedTimeString: String = "savedTime"
    var defauTimerString: String = "00 : 00 : 00"
    var startImageString: String = "play-button"
    var stopImageString: String = "stop"
    var trackerCellString: String = "TrackerCell"
    var getFetchEntityName: String = "HoursTracking"
    var idSortDescriptorString: String = "id"
    
    //Mark: - CoreData Initialization
    var managedObjectContext: NSManagedObjectContext
    
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        recordTableView.backgroundColor = UIColor.lightText
        
        //Set the default label for the timerLabel
        timerLabel.text = defauTimerString
        
        //Stop when in background and save the time when stop
        NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti:)), name: .UIApplicationDidEnterBackground, object: nil)
        //Get the time when come back to the foreground
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti:)), name: .UIApplicationWillEnterForeground, object: nil)
 
        
        //Fetch HoursTracking data from CoreData
        let fetchRecords = NSFetchRequest<HoursTracking>(entityName: getFetchEntityName)
        do{
            //Sort the result by ID
            let sortDescriptor = NSSortDescriptor(key: idSortDescriptorString, ascending: false)
            fetchRecords.sortDescriptors = [sortDescriptor]
            
            //Limit the record to 20
            fetchRecords.fetchLimit = 20
            
            //Fetch the data
            self.tracking = try self.managedObjectContext.fetch(fetchRecords)
        }
        catch{
            let fetchError =  error as NSError
            print(fetchError)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Mark: - Pause In Background : stop timer and save the current time
    func pauseWhenBackground(noti: Notification){
        if(startStopTimer == false){
            self.timer.invalidate()
            let shared = UserDefaults.standard
            shared.set(Date(), forKey: savedTimeString)
        }
    }
    
    //Mark - Enter Foreground : Calculate the diffence time between saved time and now
    func willEnterForeground(noti: Notification){
        if(startStopTimer ==  false){
            //Get the saved time which is stored when in background mode
            if let savedDate = UserDefaults.standard.object(forKey: savedTimeString) as? Date{
                
                //Get the period of time in second which is in background mode and come to foreground
                diffSec = Date().timeIntervalSince(savedDate)
                
                //Take milisecond value
                let diffMiliSec = Int(diffSec.truncatingRemainder(dividingBy: 1.0) * 100 + 0.8)
                
                //Check if total milisecon is greater than 100
                let totalMiliSec = miliSecond + diffMiliSec
                if(totalMiliSec > 100){
                    self.second += 1
                }
                
                //Check if the total second is greater than 60 and less than 3600
                let totalSec = Int(diffSec) + self.second
                if (3600 > totalSec && totalSec > 60){
                    self.min += totalSec / 60
                    self.second = totalSec % 60
                    if (self.min > 60){
                        self.hour += self.min/60
                        self.min = self.min % 60
                    }
                    //Check if the total second is greater or equal 3600
                }else if (totalSec >= 3600){
                    self.hour += totalSec / 3600
                    let temp = totalSec % 3600
                    self.min += temp / 60
                    self.second = temp % 60
                }else{
                    self.second += Int(diffSec)
                }
                
                //Generate the view for Timer Label
                let secondString = second > 9 ? "\(second)" : "0\(second)"
                let minString = min > 9 ? "\(min)" : "0\(min)"
                let hourString = hour > 9 ? "\(hour)" : "0\(hour)"
                timerLabel.text = "\(hourString):\(minString):\(secondString)"
                
                //Update the timer view when go in foreground mode
                timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TrackerViewController.updateStopTimer), userInfo: nil, repeats: true)
            }
        }
        
    }
    
   //Mark: - Start and Stop Timer button
    @IBAction func startStopTimer(_ sender: UIButton) {
        if startStopTimer == true{
            //Get the date time when click start button
            let date = Date()
            fromDate = dateTimeHandler.convertDateToDateTimeString(date: date)
            
            //Disable table view interaction
            recordTableView.isUserInteractionEnabled = false
            
            recordTableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            //Run the timer in milisecond
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TrackerViewController.updateStopTimer), userInfo: nil, repeats: true)
            
            //Change state to Stop button
            startStopTimer = false
            startStopButton.setImage(UIImage(named: stopImageString), for: UIControlState.normal)
        }
        else{
            
            let alert: UIAlertController = UIAlertController(title: "Stop Tracking", message: "Do you want to stop tracking?", preferredStyle: UIAlertControllerStyle.alert)
            let btnCancel: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (btn) in
                self.startStopTimer = false
            }
            let btnOk: UIAlertAction = UIAlertAction(title: "Stop", style: UIAlertActionStyle.default) { (btn) in
                //Get the date time after stop timer
                let date = Date()
                self.toDate = self.dateTimeHandler.convertDateToDateTimeString(date: date)
                
                self.saveRecord(from: self.fromDate, to: self.toDate, fromDate: self.fromDate, toDate: self.toDate)
                
                //Stop timer
                self.timer.invalidate()
                
                //Reset the timer after stop
                self.second = 0
                self.min = 0
                self.hour = 0
                self.miliSecond = 0
                
                //Change state to Start button
                self.startStopTimer = true
                self.startStopButton.setImage(UIImage(named: self.startImageString), for: UIControlState.normal)
            }
            alert.addAction(btnCancel)
            alert.addAction(btnOk)
            present(alert, animated: true, completion: nil)
            
            recordTableView.backgroundColor = UIColor.lightText
            
            
            
            //Enable table view interaction
            recordTableView.isUserInteractionEnabled = true
        }
        
    }
    
    //Mark: - Update Timer in miliseconds
    func updateStopTimer(){
        miliSecond += 1
        
        if (miliSecond == 100){
            second += 1
            miliSecond = 0
        }
        
        if(second == 60){
            min += 1
            second = 0
        }
        if (min == 60){
            hour += 1
            min = 0
        }
        
        //Generate view for Timer Label
        let secondString = second > 9 ? "\(second)" : "0\(second)"
        let minString = min > 9 ? "\(min)" : "0\(min)"
        let hourString = hour > 9 ? "\(hour)" : "0\(hour)"
        timerLabel.text = "\(hourString) : \(minString) : \(secondString)"
    }

    
    //Mark: - Fetch Data from CoreData
    func saveRecord(from: String, to: String, fromDate: String, toDate: String){
        //Check current max ID in data
        let id = checkID()
        
        //Convert from date and to date to string
        let tempFromDate = dateTimeHandler.convertDateTimeStringToDateString(string: fromDate)
        let tempToDate = dateTimeHandler.convertDateTimeStringToDateString(string: toDate)
        
        //Connect to coredata and initialize new record
        let data = NSEntityDescription.insertNewObject(forEntityName: getFetchEntityName, into: managedObjectContext) as? HoursTracking
        
        //Fetch data to new record
        data?.from = from
        data?.to = to
        data?.id = Int32(id)
        data?.fromDate = tempFromDate
        data?.toDate = tempToDate
        
        //Save record to core data
        do{
            try self.managedObjectContext.save()
            
            //Fetch new data from core data to current table
            let fetchRecords = NSFetchRequest<HoursTracking>(entityName: getFetchEntityName)
            do{
                //Sort fetch result by decensing id
                let sortDescriptor = NSSortDescriptor(key: idSortDescriptorString, ascending: false)
                fetchRecords.sortDescriptors = [sortDescriptor]
                
                //Limit records by 20
                fetchRecords.fetchLimit = 20
                self.tracking = try self.managedObjectContext.fetch(fetchRecords)
            }
            catch{
                let fetchError =  error as NSError
                print(fetchError)
            }
        }
        catch let error{
            print("Could not save: \(error)")
        }
        
        //Reload Table
        recordTableView.reloadData()
    }
    
    //Check max id in core data and assign new max ID + 1
    func checkID() -> Int{
        //Check if no record, add 1 to first id
        if tracking.isEmpty{
            let id = 1
            return id
        }
        else{
            //Find the current max id in data
            let maxID = Int(tracking.map{$0.id}.max()!)
            
            //return the maxID + 1
            return (maxID + 1)
        }
    }
    
    
    
    
    //MARK: - Table Controller
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Initialize value for hour, minute, second type
        var p_sec = 0
        var p_min = 0
        var p_hour = 0
        
        //Index to table cell
        let cell = tableView.dequeueReusableCell(withIdentifier: trackerCellString, for: indexPath) as! TrackerCell
        
        //Go throught records in data
        let record = self.tracking[indexPath.row]
        
        //Fetch data to display in table view
        cell.dateLabel.text = dateTimeHandler.convertDateTimeStringToDateString(string: record.from!)
        cell.idLabel.text = String(Int(record.id))
        cell.fromLabel.text = "From: \(dateTimeHandler.convertDateTimeStringToTimeString(string: record.from!))"
        cell.toLabel.text = "To: \(dateTimeHandler.convertDateTimeStringToTimeString(string: record.to!))"
        
        //Convert date time string to date and time type
        let from = dateTimeHandler.convertDateTimeStringToDate(string: record.from!)
        let to = dateTimeHandler.convertDateTimeStringToDate(string: record.to!)
        let period = Int(to.timeIntervalSince(from))
        
        //Calculate hour, minute and second by the given seconds
        p_hour = period / 3600
        let temp = period % 3600
        p_min = temp / 60
        p_sec = temp % 60
        
        //Display duration in table view
        cell.periodLabel.text = "Duration: \(p_hour)h:\(p_min)m:\(p_sec)s"
        
        return cell
    }
    
    //Clear back ground color of current table
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    //Set delete function in table and delete record in core data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert: UIAlertController = UIAlertController(title: "Record Delete", message: "Do you want to delete this record?", preferredStyle: UIAlertControllerStyle.alert)
            let btnCancel: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (btn) in
                //Do nothing
            }
            let btnDelete: UIAlertAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { (btn) in
                //Delete data in coreData
                self.managedObjectContext.delete(self.tracking[indexPath.row])
                self.tracking.remove(at: indexPath.row)
                
                //Delete records in table view
                self.recordTableView.deleteRows(at: [indexPath], with: .automatic)
                
                //Reload table view
                self.recordTableView.reloadData()
                do{
                    try self.managedObjectContext.save()
                }
                catch let error{
                    print("Could not save: \(error)")
                }
            }
            alert.addAction(btnCancel)
            alert.addAction(btnDelete)
            present(alert, animated: true, completion: nil)
            
        }
    }

}
