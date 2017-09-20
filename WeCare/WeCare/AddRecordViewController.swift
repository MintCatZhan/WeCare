//
//  AddRecordViewController.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 14/9/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit

protocol AddRecord {
    func addRecord(from: String, to: String)
}

class AddRecordViewController: UIViewController {

    @IBOutlet weak var fromDatePickerTextField: UITextField!
    @IBOutlet weak var toDatePickerTextField: UITextField!
    
    var fromDatePicker = UIDatePicker()
    var toDatePicker = UIDatePicker()
    
    var delegate: AddRecord?
    
    var dateTimeHandler = DateTimeHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createFromDatePicker()
        createToDatePicker()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createFromDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneFromPressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        fromDatePickerTextField.inputAccessoryView =  toolbar
        
        //Assign date picker to textfield
        fromDatePickerTextField.inputView = fromDatePicker
    }
    
    func createToDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneToPressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        toDatePickerTextField.inputAccessoryView = toolbar
        
        //Assign date picker to textfield
        toDatePickerTextField.inputView = toDatePicker
    }
    
    func doneFromPressed(){
        let fromDateString: String = dateTimeHandler.convertDateToDateTimeString(date: fromDatePicker.date)
        fromDatePickerTextField.text = fromDateString
        self.view.endEditing(true)
    }
    
    func doneToPressed(){
        let toDateString: String = dateTimeHandler.convertDateToDateTimeString(date: toDatePicker.date)
        toDatePickerTextField.text = toDateString
        self.view.endEditing(true)
    }
    
    @IBAction func saveRecordButton(_ sender: UIBarButtonItem) {
        if toDatePickerTextField.text == "" || fromDatePickerTextField.text == ""{
            if fromDatePickerTextField.text == ""{
                let alert: UIAlertController = UIAlertController(title: "Missing Input!", message: "From Date Field is empty!", preferredStyle: UIAlertControllerStyle.alert)
                let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                    
                }
                alert.addAction(btnOk)
                present(alert, animated: true, completion: nil)
            }
            if toDatePickerTextField.text == ""{
                let alert: UIAlertController = UIAlertController(title: "Missing Input!", message: "To Date Field is empty!", preferredStyle: UIAlertControllerStyle.alert)
                let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                    
                }
                alert.addAction(btnOk)
                present(alert, animated: true, completion: nil)
            }
        }
        else{
            
            if Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!), to: dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!), toGranularity: .day) == ComparisonResult.orderedDescending{
                
                let alert: UIAlertController = UIAlertController(title: "Wrong input!", message: "Start date must before End Date", preferredStyle: UIAlertControllerStyle.alert)
                let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                }
                alert.addAction(btnOk)
                present(alert, animated: true, completion: nil)
            }
            else if (Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!), to: dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!), toGranularity: .day) != ComparisonResult.orderedDescending && Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!), to: dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!), toGranularity: .hour) == ComparisonResult.orderedDescending){
                let alert: UIAlertController = UIAlertController(title: "Wrong input!", message: "Start hour must smaller than End hour", preferredStyle: UIAlertControllerStyle.alert)
                let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                }
                alert.addAction(btnOk)
                present(alert, animated: true, completion: nil)
            }
            else if(Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!), to: dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!), toGranularity: .day) != ComparisonResult.orderedDescending && Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!), to: dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!), toGranularity: .hour) != ComparisonResult.orderedDescending && Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!), to: dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!), toGranularity: .minute) == ComparisonResult.orderedDescending){
            
                let alert: UIAlertController = UIAlertController(title: "Wrong input!", message: "Start hour must smaller than End hour", preferredStyle: UIAlertControllerStyle.alert)
                let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                }
                alert.addAction(btnOk)
                present(alert, animated: true, completion: nil)
            }
            else{
                let interval = dateTimeHandler.convertDateTimeStringToDate(string: toDatePickerTextField.text!).timeIntervalSince(dateTimeHandler.convertDateTimeStringToDate(string: fromDatePickerTextField.text!))
                if interval > 86400{
                    let alert: UIAlertController = UIAlertController(title: "Warning", message: "You must not work over 24 hours per day", preferredStyle: UIAlertControllerStyle.alert)
                    let btnOk: UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (btn) in
                    }
                    alert.addAction(btnOk)
                    present(alert, animated: true, completion: nil)
                }
                else
                {
                    //Save Record
                    delegate?.addRecord(from: fromDatePickerTextField.text!, to: toDatePickerTextField.text!)
                    self.navigationController?.popViewController(animated: true)
                }

            }
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
