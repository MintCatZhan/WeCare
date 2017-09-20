//
//  ConfigureVisualisationViewController.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 14/9/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit
protocol SetChartSetting {
    func setChartSetting(salaryPerHour: Double, startDay: String, place: String)
}

class ConfigureVisualisationViewController: UIViewController{
    @IBOutlet weak var salaryPerHourTextField: UITextField!
    @IBOutlet weak var startDaySegment: UISegmentedControl!
    @IBOutlet weak var daySegmentControl: UISegmentedControl!
    @IBOutlet weak var placeSegmentControl: UISegmentedControl!

    var startDay: String = "Sun"
    var startDate: Date!
    var startOfWeek: Date!
    var delegate: SetChartSetting!
    var startDateSettedState: String?
    var placeSettedState: String?
    var salarySettedState: Double?
    var place: String = "QLD"

    override func viewDidLoad() {
        super.viewDidLoad()
        if startDateSettedState == nil{
            //Do Nothing
        }
        else{
            salaryPerHourTextField.text = NSString(format: "%.2f", salarySettedState!) as String
            if startDateSettedState == "Sun"{
                daySegmentControl.selectedSegmentIndex = 0
                startDay = "Sun"
            }
            if startDateSettedState == "Mon"{
                daySegmentControl.selectedSegmentIndex = 1
                startDay = "Mon"
            }
            if startDateSettedState == "Tue"{
                daySegmentControl.selectedSegmentIndex = 2
                startDay = "Tue"
            }
            if startDateSettedState == "Wed"{
                daySegmentControl.selectedSegmentIndex = 3
                startDay = "Wed"
            }
            if startDateSettedState == "Thu"{
                daySegmentControl.selectedSegmentIndex = 4
                startDay = "Thu"
            }
            if startDateSettedState == "Fri"{
                daySegmentControl.selectedSegmentIndex = 5
                startDay = "Fri"
            }
            if startDateSettedState == "Sat"{
                daySegmentControl.selectedSegmentIndex = 6
                startDay = "Sat"
            }
        }
        
        if placeSettedState == nil{
            //Do nothing
        }
        else{
            if placeSettedState == "NSW"{
                placeSegmentControl.selectedSegmentIndex = 0
                place = "NSW"
            }
            if placeSettedState == "QLD"{
                placeSegmentControl.selectedSegmentIndex = 1
                place = "QLD"
            }
            if placeSettedState == "SA"{
                placeSegmentControl.selectedSegmentIndex = 2
                place = "SA"
            }
            if placeSettedState == "TAS"{
                placeSegmentControl.selectedSegmentIndex = 3
                place = "TAS"
            }
            if placeSettedState == "VIC"{
                placeSegmentControl.selectedSegmentIndex = 4
                place = "VIC"
            }
            if placeSettedState == "WA"{
                placeSegmentControl.selectedSegmentIndex = 5
                place = "WA"
            }
            if placeSettedState == "ACT"{
                placeSegmentControl.selectedSegmentIndex = 6
                place = "ACT"
            }
            if placeSettedState == "NT"{
                placeSegmentControl.selectedSegmentIndex = 7
                place = "NT"
            }
        }
        //Initialize calendar
        let calendar = Calendar.current
        
        //Initialize current Date
        let date = Date()
        
        //get the first day of current week
        startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        
        //Initialize value for start date
        startDate = startOfWeek
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func setChartToDefault(_ sender: UIButton) {
        daySegmentControl.selectedSegmentIndex = 0
        startDay = "Sun"
        placeSegmentControl.selectedSegmentIndex = 0
        place = "NSW"
        salaryPerHourTextField.text = "0"
    }
    @IBAction func dayPickerSegmentButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            startDay = "Sun"
            startDate = startOfWeek
            break
        case 1:
            startDay = "Mon"
            startDate = Calendar.current.date(byAdding: .day, value: 1, to: startOfWeek)
            break
        case 2:
            startDay = "Tue"
            startDate = Calendar.current.date(byAdding: .day, value: 2, to: startOfWeek)
            break
        case 3:
            startDay = "Wed"
            startDate = Calendar.current.date(byAdding: .day, value: 3, to: startOfWeek)
            break
        case 4:
            startDay = "Thu"
            startDate = Calendar.current.date(byAdding: .day, value: 4, to: startOfWeek)
            break
        case 5:
            startDay = "Fri"
            startDate = Calendar.current.date(byAdding: .day, value: 5, to: startOfWeek)
            break
        case 6:
            startDay = "Sat"
            startDate = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek)
            break
        default:
            startDay = "Sun"
            startDate = startOfWeek
            break
        }
    }
    
    @IBAction func placePickerSegmentButton(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            place = "NSW"
            break
        case 1:
            place = "QLD"
            break
        case 2:
            place = "SA"
            break
        case 3:
            place = "TAS"
            break
        case 4:
            place = "VIC"
            break
        case 5:
            place = "WA"
            break
        case 6:
            place = "ACT"
            break
        case 7:
            place = "NT"
            break
        default:
            place = "VIC"
            break
        }
    }
    
    @IBAction func checkUnderPaidButon(_ sender: UIButton) {
        let fairWorkURL: String = "https://calculate.fairwork.gov.au/FindYourAward"
        let url = NSURL(string: fairWorkURL)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }

    @IBAction func saveConfigureChartButton(_ sender: UIBarButtonItem) {
        if (Double(salaryPerHourTextField.text!) == nil){
            let alert: UIAlertController = UIAlertController(title: "Wrong Input!", message: "Wrong Input for Salary", preferredStyle: UIAlertControllerStyle.alert)
            let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                
            }
            alert.addAction(btnOk)
            present(alert, animated: true, completion: nil)
        }
        else{
            self.delegate.setChartSetting(salaryPerHour: Double(salaryPerHourTextField.text!)!, startDay: startDay, place: place)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
