//
//  VisualisationViewController.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 31/8/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit
import Charts
import CoreData

class VisualisationViewController: UIViewController, SetChartSetting {
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var currentWeekButton: UIButton!
    @IBOutlet weak var totalHoursLabel: UILabel!
    
    @IBOutlet weak var nextWeekButton: UIButton!
    @IBOutlet weak var preWeekButton: UIButton!
    
    //Mark: - DateTimeHandler Initialization
    var dateTimeHandler = DateTimeHandler()
    
    //Mark: - Default Array Initialization
    var defaultDateArray: [Int] = [0,1,2,3,4,5,6]
    var hours = [Double]()
    var days = [String]()
    
    //Mark: - Default String Initialization
    var getFetchEntityName: String = "HoursTracking"
    var idSortDescriptorString: String = "id"
    var getHolidayFetchString: String = "Holidays"
    var stateSortDescriptorString: String = "state"
    
    //Mark: - CoreData Initialization
    var tracking = [HoursTracking]()
    var holidayData = [Holidays]()
    var managedObjectContext: NSManagedObjectContext
    
    //Store Chart State
    var userStandard = UserDefaults.standard
    var salaryStandard: Double = 0.0
    
    var color = [UIColor]()
    
    //Init persistance for coreData
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var placeStandard = userStandard.string(forKey: "PlaceStandard")
        if placeStandard == nil {
            placeStandard = "QLD"
        }
        loadHolidayData(state: placeStandard!)
        if holidayData.count == 0 {
            setHolidayData()
        }
        let startDay = userStandard.string(forKey: "StartDay")
        salaryStandard = userStandard.double(forKey: "SalaryStandard")
        
        
        if startDay == nil{
            days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            defaultDateArray = [0,1,2,3,4,5,6]
        }
        else{
            if startDay == "Mon"{
                days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                defaultDateArray = [1,2,3,4,5,6,7]
                //Save state of start Day to shared prefences
            }
            if startDay == "Tue"{
                days = ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"]
                defaultDateArray = [2,3,4,5,6,7, 8]
            }
            if startDay == "Wed"{
                days = ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"]
                defaultDateArray = [3,4,5,6,7,8,9]
            }
            if startDay == "Thu"{
                days = ["Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"]
                defaultDateArray = [4,5,6,7,8,9,10]
            }
            if startDay == "Fri"{
                days = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
                defaultDateArray = [5,6,7,8,9,10,11]
            }
            if startDay == "Sat"{
                days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
                defaultDateArray = [6,7,8,9,10,11,12]
            }
            if startDay == "Sun"{
                days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                defaultDateArray = [0,1,2,3,4,5,6]
            }
        }
        
        
        //fetch data
        loadData()
        
        periodLabel.backgroundColor = UIColor(red: 138/255, green: 206/255, blue: 205/255, alpha: 1)
        currentWeekButton.backgroundColor = UIColor(red: 138/255, green: 206/255, blue: 205/255, alpha: 1)
        currentWeekButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //Show current week bar chart
        calculateHoursWeekly()
        barChartView.noDataText = "No Data Currently"
        barChartView.chartDescription?.text = ""
        setBarChart(months: days, hours: hours, color: color)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let totalHours = self.hours[0] + self.hours[1] + self.hours[2] + self.hours[3] + self.hours[4] + self.hours[5] + self.hours[6]
        let tempMins = totalHours.truncatingRemainder(dividingBy: 1.0)
        let tempHours: Int = Int(totalHours - totalHours.truncatingRemainder(dividingBy: 1.0))
        let totalMins = tempMins * 60
        let minDisplay:Int = Int(totalMins - totalMins.truncatingRemainder(dividingBy: 1.0))
        let tempSec = totalMins.truncatingRemainder(dividingBy: 1.0)
        let totalSec: Int = Int(tempSec * 60)
        
        
        
        if tempHours > 0{
            totalHoursLabel.text = "\(tempHours)h:\(minDisplay)m:\(totalSec)s"
        }
        
        if tempHours == 0{
            if minDisplay > 0 {
                totalHoursLabel.text = "\(minDisplay)m:\(totalSec)s"
            }
            if minDisplay == 0 {
                totalHoursLabel.text = "\(totalSec)s"
            }
        }
        
        
        
        let salary = totalHours * salaryStandard
        resultLabel.text = NSString(format: "%.2f $", salary) as String
        
        check20Hours(totalHours: totalHours)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    

    
    @IBAction func currentWeekButton(_ sender: UIButton) {
        currentWeekButton.setTitle("Current Week", for: .normal)
        nextWeekButton.isEnabled = true
        preWeekButton.isEnabled = true
        
        var placeStandard = userStandard.string(forKey: "PlaceStandard")
        if placeStandard == nil {
            placeStandard = "QLD"
        }
        loadHolidayData(state: placeStandard!)
        
        let startDay = userStandard.string(forKey: "StartDay")
        salaryStandard = userStandard.double(forKey: "SalaryStandard")
        if startDay == nil{
            days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            defaultDateArray = [0,1,2,3,4,5,6]
        }
        else{
            if startDay == "Mon"{
                days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                defaultDateArray = [1,2,3,4,5,6,7]
                //Save state of start Day to shared prefences
            }
            if startDay == "Tue"{
                days = ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"]
                defaultDateArray = [2,3,4,5,6,7, 8]
            }
            if startDay == "Wed"{
                days = ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"]
                defaultDateArray = [3,4,5,6,7,8,9]
            }
            if startDay == "Thu"{
                days = ["Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"]
                defaultDateArray = [4,5,6,7,8,9,10]
            }
            if startDay == "Fri"{
                days = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
                defaultDateArray = [5,6,7,8,9,10,11]
            }
            if startDay == "Sat"{
                days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
                defaultDateArray = [6,7,8,9,10,11,12]
            }
            if startDay == "Sun"{
                days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                defaultDateArray = [0,1,2,3,4,5,6]
            }
        }
        
        
        resultLabel.text = "0"
        
        //Fetch Data
        loadData()
        
        //Show current week bar chart
        calculateHoursWeekly()
        barChartView.noDataText = "No Data Currently"
        barChartView.chartDescription?.text = ""
        setBarChart(months: days, hours: hours, color: color)

        let totalHours = self.hours[0] + self.hours[1] + self.hours[2] + self.hours[3] + self.hours[4] + self.hours[5] + self.hours[6]
        let tempMins = totalHours.truncatingRemainder(dividingBy: 1.0)
        let tempHours: Int = Int(totalHours - totalHours.truncatingRemainder(dividingBy: 1.0))
        let totalMins = tempMins * 60
        let minDisplay:Int = Int(totalMins - totalMins.truncatingRemainder(dividingBy: 1.0))
        let tempSec = totalMins.truncatingRemainder(dividingBy: 1.0)
        let totalSec: Int = Int(tempSec * 60)
        
        
        
        if tempHours > 0{
            totalHoursLabel.text = "\(tempHours)h:\(minDisplay)m:\(totalSec)s"
        }
        
        if tempHours == 0{
            if minDisplay > 0 {
                totalHoursLabel.text = "\(minDisplay)m:\(totalSec)s"
            }
            if minDisplay == 0 {
                totalHoursLabel.text = "\(totalSec)s"
            }
        }
        let salary = totalHours * salaryStandard
        resultLabel.text = NSString(format: "%.2f $", salary) as String
    }
    
    
    @IBAction func nextWeekButton(_ sender: UIButton) {
        currentWeekButton.setTitle("Go to Current Week", for: .normal)
        
        resultLabel.text = "0"
        
        //Set array day for next week
        for i in 0 ..< defaultDateArray.count{
            defaultDateArray[i] += 7
        }
        
        //fetch Data
        loadData()
        
        
        //Initialize the first day of week
        let startCurrentWeek = startOfWeek(dateString: dateTimeHandler.convertDateToDateTimeString(date: Date()))
        
        //set period for bar chart
        setPeriodLabelText(startCurrentWeek: startCurrentWeek)
        //Calculate hours per day
        for i in 0 ..< defaultDateArray.count{
            calculateHoursDaily(startCurrentWeek: startCurrentWeek, value: defaultDateArray[i])
        }
        
        //Show next week bar chart
        barChartView.noDataText = "No Data Currently"
        barChartView.chartDescription?.text = ""
        setBarChart(months: days, hours: hours, color: color)
        let totalHours = self.hours[0] + self.hours[1] + self.hours[2] + self.hours[3] + self.hours[4] + self.hours[5] + self.hours[6]
        let tempMins = totalHours.truncatingRemainder(dividingBy: 1.0)
        let tempHours: Int = Int(totalHours - totalHours.truncatingRemainder(dividingBy: 1.0))
        let totalMins = tempMins * 60
        let minDisplay:Int = Int(totalMins - totalMins.truncatingRemainder(dividingBy: 1.0))
        let tempSec = totalMins.truncatingRemainder(dividingBy: 1.0)
        let totalSec: Int = Int(tempSec * 60)
        
        
        
        if tempHours > 0{
            totalHoursLabel.text = "\(tempHours)h:\(minDisplay)m:\(totalSec)s"
        }
        
        if tempHours == 0{
            if minDisplay > 0 {
                totalHoursLabel.text = "\(minDisplay)m:\(totalSec)s"
            }
            if minDisplay == 0 {
                totalHoursLabel.text = "\(totalSec)s"
            }
        }

        let salary = totalHours * salaryStandard
        resultLabel.text = NSString(format: "%.2f $", salary) as String
        
    }
    @IBAction func preWeekButton(_ sender: UIButton) {
        currentWeekButton.setTitle("Go to Current Week", for: .normal)
        
        resultLabel.text = "0"
        
        //Set array for previous week
        for i in 0 ..< defaultDateArray.count{
            defaultDateArray[i] -= 7
        }
        
        //Fetch Data
        loadData()
        
        
        //Initialize the first day of week
        let startCurrentWeek = startOfWeek(dateString: dateTimeHandler.convertDateToDateTimeString(date: Date()))
        
        //set period for bar chart
        setPeriodLabelText(startCurrentWeek: startCurrentWeek)
        
        //Calculate hours per day
        for i in 0 ..< defaultDateArray.count{
            calculateHoursDaily(startCurrentWeek: startCurrentWeek, value: defaultDateArray[i])
        }
        
        //Show previous week bar chart
        barChartView.noDataText = "No Data Currently"
        barChartView.chartDescription?.text = ""
        setBarChart(months: days, hours: hours, color: color)
        
        let totalHours = self.hours[0] + self.hours[1] + self.hours[2] + self.hours[3] + self.hours[4] + self.hours[5] + self.hours[6]
        let tempMins = totalHours.truncatingRemainder(dividingBy: 1.0)
        let tempHours: Int = Int(totalHours - totalHours.truncatingRemainder(dividingBy: 1.0))
        let totalMins = tempMins * 60
        let minDisplay:Int = Int(totalMins - totalMins.truncatingRemainder(dividingBy: 1.0))
        let tempSec = totalMins.truncatingRemainder(dividingBy: 1.0)
        let totalSec: Int = Int(tempSec * 60)
        
        
        
        if tempHours > 0{
            totalHoursLabel.text = "\(tempHours)h:\(minDisplay)m:\(totalSec)s"
        }
        
        if tempHours == 0{
            if minDisplay > 0 {
                totalHoursLabel.text = "\(minDisplay)m:\(totalSec)s"
            }
            if minDisplay == 0 {
                totalHoursLabel.text = "\(totalSec)s"
            }
        }
        let salary = totalHours * salaryStandard
        resultLabel.text = NSString(format: "%.2f $", salary) as String
    }
    
    func setPeriodLabelText(startCurrentWeek: Date){
        //Initialize the first day of week
        let sunday = Calendar.current.date(byAdding: .day, value: defaultDateArray[0], to: startCurrentWeek)!
        
        //Initialize the last day of week
        let saturday = Calendar.current.date(byAdding: .day, value: defaultDateArray[6], to: startCurrentWeek)!
        
        //Convert first day of week and last day of week to string
        let sundayString = dateTimeHandler.convertDateTimeStringToDateString(string: dateTimeHandler.convertDateToDateTimeString(date: sunday))
        let saturdayString = dateTimeHandler.convertDateTimeStringToDateString(string: dateTimeHandler.convertDateToDateTimeString(date: saturday))
        
        //Fetch String to period label
        periodLabel.text = "\(sundayString) to \(saturdayString)"
    }
    
    //Mark: - Fetch Holiday Data
    func loadHolidayData(state: String){
        //Fetch holiday data from CoreData
        let fetchRecords = NSFetchRequest<Holidays>(entityName: getHolidayFetchString)
        do{
            let predicate = NSPredicate(format: "state = %@", state)
            fetchRecords.predicate = predicate
            
            //Fetch the data
            self.holidayData = try self.managedObjectContext.fetch(fetchRecords)
        }
        catch{
            let fetchError =  error as NSError
            print(fetchError)
        }
    }
  
    //Mark: - Fetch Data and generate data array for bar chart
    func loadData() {
        hours = []
        //Fetch HoursTracking data from CoreData
        let fetchRecords = NSFetchRequest<HoursTracking>(entityName: getFetchEntityName)
        do{
            //Sort the result by ID
            let sortDescriptor = NSSortDescriptor(key: idSortDescriptorString, ascending: true)
            fetchRecords.sortDescriptors = [sortDescriptor]
            //Fetch the data
            self.tracking = try self.managedObjectContext.fetch(fetchRecords)
        }
        catch{
            let fetchError =  error as NSError
            print(fetchError)
        }
    }
    
    //Mark - Check over 20 hours per week
    func check20Hours(totalHours: Double){
        if totalHours > 20 {
            let alert: UIAlertController = UIAlertController(title: "Warning!", message: "You have already worked more than 20 hours this week!", preferredStyle: UIAlertControllerStyle.alert)
            let btnOk: UIAlertAction = UIAlertAction(title: "Got it", style: UIAlertActionStyle.default) { (btn) in
                
            }
            alert.addAction(btnOk)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //Mark - Calculate Hours for current week
    func calculateHoursWeekly(){
        
        //Initialize the first day of current week
        let startCurrentWeek = startOfWeek(dateString: dateTimeHandler.convertDateToDateTimeString(date: Date()))
        
        //Set period label to bar chart
        setPeriodLabelText(startCurrentWeek: startCurrentWeek)
        
        //Calculate the total hours each day
        for i in 0 ..< defaultDateArray.count{
            calculateHoursDaily(startCurrentWeek: startCurrentWeek, value: defaultDateArray[i])
        }
    }
    
    //Mark: - For Next and Previous Week
    
    //Mark: - Calculate total hours each day
    func calculateHoursDaily(startCurrentWeek: Date, value: Int){
        var checkColor: Bool = true
        
        if color.count > 6 {
            color = []
        }
        //Initialize total seconds and total hours each day
        var totalSec: Double = 0
        var hour: Double = 0
        
        //First day of the week
        let thisDay = Calendar.current.date(byAdding: .day, value: value, to: startCurrentWeek)!
        
        //Calculate the total of duration in each day
        for i in tracking{
            if (Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: i.from!), to: thisDay, toGranularity: .day) == ComparisonResult.orderedSame) {
                let from = dateTimeHandler.convertDateTimeStringToDate(string: i.from!)
                let to = dateTimeHandler.convertDateTimeStringToDate(string: i.to!)
                let period = to.timeIntervalSince(from)
                totalSec += period
            }
        }
        //Convert seconds to hours
        hour = totalSec/3600
        
        //Add total hours each day to array
        hours.append(hour)
        
        //Add Color for barchar
        for holiday in holidayData{
            if Calendar.current.compare(thisDay, to: dateTimeHandler.convertDateStringToDate(string: holiday.date!), toGranularity: .day) == ComparisonResult.orderedSame{
                color.append(UIColor.red)
                checkColor = false
            }
        }
        
        if checkColor == true{
            color.append(UIColor(red: 78/255, green: 202/255, blue: 224/255, alpha: 1))
        }
    }
    
    
    //Mark: - Bar Chart Generation
    func setBarChart(months: [String], hours: [Double], color: [UIColor]){
        //Initialize bar chart data entry
        var dataArray = [BarChartDataEntry]()
        
        //Fetch data from arrays to bar chart data entry
        for i in 0..<months.count{
            let data: BarChartDataEntry = BarChartDataEntry(x: Double(i), yValues: [hours[i]])
            dataArray.append(data)
        }
        
        //Generate bar chart data set
        let dataSet:BarChartDataSet = BarChartDataSet(values: dataArray, label: "Days")
        
        //Set color for column in bar char
        //dataSet.colors = ChartColorTemplates.liberty()
        //dataSet.colors = [UIColor(red: 78/255, green: 202/255, blue: 224/255, alpha: 1)]
        dataSet.colors = color
        
        //Format Number in bar chart to String
        let formatter = ChartStringFormatter()
        formatter.nameValues = months
        barChartView.xAxis.valueFormatter = formatter
        barChartView.xAxis.granularity = 1
        
        //Fetch data set to bar chart data
        let dataChart = BarChartData(dataSet: dataSet)
        
        //Initiaize bar chart animation
        barChartView.animate(xAxisDuration: 2, easingOption: .easeInBounce)
        barChartView.animate(yAxisDuration: 2, easingOption: .easeInBounce)
        
        //Set bar chart view
        barChartView.data = dataChart
    }
    
    //Mark: - Get the first day of current month
    func startOfMonth(dateString: String) -> Date{
        //Initialize calendar
        let calendar = Calendar.current
        
        //Set format for current month in current year
        let monthStartComponents = calendar.dateComponents([.year, .month], from: dateTimeHandler.convertDateTimeStringToDate(string: dateString))
        
        //Get the first day of current month
        let monthStart = calendar.date(from: monthStartComponents)
        
        return monthStart!
    }
    
    //Mark: - Get the final day of current month
    func endOfMonth(dateString: String) -> Date {
        //Initialize calendar
        let calendar = Calendar.current
        
        //Set format for current month in current year
        let monthStartComponents = calendar.dateComponents([.year, .month], from: dateTimeHandler.convertDateTimeStringToDate(string: dateString))

        //Get the first day of current month
        let monthStart = calendar.date(from: monthStartComponents)
        
        //Add 1 month and minus 1 day to the first day of current month to get the last day of the month
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: monthStart!)
        
        return endOfMonth!
    }
    
    //Mark: - Get the first day of current week
    func startOfWeek(dateString: String) -> Date{
        //Convert date string in core data to date type
        let date = dateTimeHandler.convertDateTimeStringToDate(string: dateString)
        
        //Initialize calendar
        let calendar = Calendar.current
        
        //get the first day of current week
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        
        return startOfWeek!
    }
    
    //Mark: - Get the last day of current week
    func endOfWeek(dateString: String) -> Date{
        //get the last day of current week by add 6 days to the first day of current week
        let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek(dateString: dateString))
        return endOfWeek!
    }    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let configureChartSegueString: String = "ConfigureChartSegue"
        if segue.identifier == configureChartSegueString {
            let configureChartController = segue.destination as! ConfigureVisualisationViewController
            configureChartController.salarySettedState = salaryStandard
            configureChartController.startDateSettedState = userStandard.string(forKey: "StartDay")
            configureChartController.placeSettedState = userStandard.string(forKey: "PlaceStandard")
            configureChartController.delegate = self

        }
    }
    
    func setChartSetting(salaryPerHour: Double, startDay: String, place: String) {
        if startDay == "Mon"{
            days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            //Save state of start Day to shared prefences
            userStandard.set("Mon", forKey: "StartDay")
        }
        if startDay == "Tue"{
            days = ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"]
            userStandard.set("Tue", forKey: "StartDay")
        }
        if startDay == "Wed"{
            days = ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"]
            userStandard.set("Wed", forKey: "StartDay")
        }
        if startDay == "Thu"{
            days = ["Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"]
            userStandard.set("Thu", forKey: "StartDay")
        }
        if startDay == "Fri"{
            days = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
            userStandard.set("Fri", forKey: "StartDay")
        }
        if startDay == "Sat"{
            days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
            userStandard.set("Sat", forKey: "StartDay")
        }
        if startDay == "Sun"{
            days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            userStandard.set("Sun", forKey: "StartDay")
        }
        
        userStandard.set(salaryPerHour, forKey: "SalaryStandard")
        
        userStandard.set(place, forKey: "PlaceStandard")
        
        currentWeekButton.setTitle("Reload Data", for: .normal)
        nextWeekButton.isEnabled = false
        preWeekButton.isEnabled = false
    }
    
    func setHolidayData(){
        
        //NEW YEARS DAY
        var data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "01-01-2017"
        data?.name = "New Years Day"
        
        //New Year Holiday
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "02-01-2017"
        data?.name = "New Years Day"
        
        //AUSTRALIA DAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "26-01-2017"
        data?.name = "Australia Day"
        
        //LABOUR DAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "06-03-2017"
        data?.name = "Labour Day"
        
        //HOLI
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "13-03-2017"
        data?.name = "Adelaide Cup"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "13-03-2017"
        data?.name = "Canberra Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "13-03-2017"
        data?.name = "Labour Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "13-03-2017"
        data?.name = "Labour Day"
        
        
        //GOOD FRIDAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "14-04-2017"
        data?.name = "Good Friday"
        
        //EASTER SATURDAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "15-04-2017"
        data?.name = "Easter Saturday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "15-04-2017"
        data?.name = "Easter Saturday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "15-04-2017"
        data?.name = "Easter Saturday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "15-04-2017"
        data?.name = "Easter Saturday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "15-04-2017"
        data?.name = "Easter Saturday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "15-04-2017"
        data?.name = "Easter Saturday"
        
        //EASTER SUNDAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "16-04-2017"
        data?.name = "Easter Sunday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "16-04-2017"
        data?.name = "Easter Sunday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "16-04-2017"
        data?.name = "Easter Sunday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "16-04-2017"
        data?.name = "Easter Sunday"
        
        //EASTER MONDAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "17-04-2017"
        data?.name = "Easter Monday"
        
        //EASTER TUESDAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "18-04-2017"
        data?.name = "Easter Tuesday"
        
        //ANZAC DAY
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "25-04-2017"
        data?.name = "ANZAC Day"
        
        //Labour Day
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "01-05-2017"
        data?.name = "Labour Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "01-05-2017"
        data?.name = "Labour Day"
        
        //Western Australia Day
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "05-06-2017"
        data?.name = "Western Australia Day"
        
        //Queen's Birthday
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "12-06-2017"
        data?.name = "Queen's Birthday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "12-06-2017"
        data?.name = "Queen's Birthday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "12-06-2017"
        data?.name = "Queen's Birthday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "12-06-2017"
        data?.name = "Queen's Birthday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "12-06-2017"
        data?.name = "Queen's Birthday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "12-06-2017"
        data?.name = "Queen's Birthday"
        
        //Holiday
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "07-08-2017"
        data?.name = "Picnic Day"
        
        //September 25
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "25-09-2017"
        data?.name = "Family & Community Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = ""
        data?.date = "25-09-2017"
        data?.name = "Queens Birthday"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "29-09-2017"
        data?.name = "Grand Final Eve"
        
        //Labour day
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "02-10-2017"
        data?.name = "Labour Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "02-10-2017"
        data?.name = "Labour Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "02-10-2017"
        data?.name = "Labour Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "02-10-2017"
        data?.name = "Queen's Birthday"
        
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "07-11-2017"
        data?.name = "Melbourne Cup Day"
        
        //Christmas Day
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "25-12-2017"
        data?.name = "Christmas Day"
        
        //Boxing day
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NSW"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "QLD"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "SA"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "TAS"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "VIC"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "WA"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "ACT"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        data = NSEntityDescription.insertNewObject(forEntityName: getHolidayFetchString, into: managedObjectContext) as? Holidays
        data?.state = "NT"
        data?.date = "26-12-2017"
        data?.name = "Boxing Day"
        
        
        do{
            try self.managedObjectContext.save()
        }
        catch let error{
            print("Could not save: \(error)")
        }
    }

    
}
