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

class VisualisationViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var periodLabel: UILabel!
    
    //Mark: - DateTimeHandler Initialization
    var dateTimeHandler = DateTimeHandler()
    
    //Mark: - Default Array Initialization
    var defaultDateArray: [Int] = [0,1,2,3,4,5,6]
    var hours = [Double]()
    var days = [String]()
    
    //Mark: - Default String Initialization
    var getFetchEntityName: String = "HoursTracking"
    var idSortDescriptorString: String = "id"
    
    //Mark: - CoreData Initialization
    var tracking = [HoursTracking]()
    var managedObjectContext: NSManagedObjectContext
    
    //Init persistance for coreData
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch data
        loadData()
        
        //Show current week bar chart
        calculateHoursWeekly()
        barChartView.noDataText = "No Data Currently"
        barChartView.chartDescription?.text = ""
        setBarChart(months: days, hours: hours)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func currentWeekButton(_ sender: UIButton) {
        //Fetch Data
        loadData()
        
        //Show current week bar chart
        calculateHoursWeekly()
        barChartView.noDataText = "No Data Currently"
        barChartView.chartDescription?.text = ""
        setBarChart(months: days, hours: hours)

    }
    @IBAction func nextWeekButton(_ sender: UIButton) {
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
        setBarChart(months: days, hours: hours)

    }
    @IBAction func preWeekButton(_ sender: UIButton) {
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
        setBarChart(months: days, hours: hours)

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
        periodLabel.text = "Period: \(sundayString) To \(saturdayString)"
    }
  
    //Mark: - Fetch Data and generate data array for bar chart
    func loadData() {
        days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
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
    
    //Mark - Calculate Hours for current week
    func calculateHoursWeekly(){
        //Initialize defaut value for default date array
        defaultDateArray = [0,1,2,3,4,5,6]
        
        //Initialize the first day of current week
        let startCurrentWeek = startOfWeek(dateString: dateTimeHandler.convertDateToDateTimeString(date: Date()))
        
        //Set period label to bar chart
        setPeriodLabelText(startCurrentWeek: startCurrentWeek)
        
        //Calculate the total hours each day
        for i in 0 ..< defaultDateArray.count{
            calculateHoursDaily(startCurrentWeek: startCurrentWeek, value: defaultDateArray[i])
        }
    }
    
    //Mark: - Calculate total hours each day
    func calculateHoursDaily(startCurrentWeek: Date, value: Int){
        //Initialize total seconds and total hours each day
        var totalSec: Double = 0
        var hour: Double = 0
        
        //First day of the week
        let sunday = Calendar.current.date(byAdding: .day, value: value, to: startCurrentWeek)!
        
        //Calculate the total of duration in each day
        for i in tracking{
            if (Calendar.current.compare(dateTimeHandler.convertDateTimeStringToDate(string: i.from!), to: sunday, toGranularity: .day) == ComparisonResult.orderedSame) {
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
    }
    
    
    //Mark: - Bar Chart Generation
    func setBarChart(months: [String], hours: [Double]){
        //Initialize bar chart data entry
        var dataArray = [BarChartDataEntry]()
        
        //Fetch data from arrays to bar chart data entry
        for i in 0..<months.count{
            let data: BarChartDataEntry = BarChartDataEntry(x: Double(i), yValues: [hours[i]])
            dataArray.append(data)
        }
        
        //Generate bar chart data set
        let dataSet:BarChartDataSet = BarChartDataSet(values: dataArray, label: "Working hours")
        
        //Set color for column in bar char
        dataSet.colors = ChartColorTemplates.liberty()
        
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

    //    func durationByMonths(trackingList: [HoursTracking]){
    //        var totolHours: Int = 0
    //        for i in trackingList{
    //            let date = dateTimeHandler.convertDateTimeStringToDate(string: i.from!)
    //
    //            if (date > startOfMonth(dateString: i.from!) && date < endOfMonth(dateString: i.from!)){
    //                let from = dateTimeHandler.convertDateTimeStringToDate(string: i.from!)
    //                let to = dateTimeHandler.convertDateTimeStringToDate(string: i.to!)
    //                let period = Int(to.timeIntervalSince(from))
    //                totolHours += period
    //            }
    //            else{
    //                print("false")
    //            }
    //
    //        }
    //        print(totolHours)
    //    }

}
