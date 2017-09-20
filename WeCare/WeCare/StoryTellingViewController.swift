//
//  StoryTellingViewController.swift
//  WeCare
//
//  Created by Nguyen Dinh Thang on 17/9/17.
//  Copyright © 2017 Nguyen Dinh Thang. All rights reserved.
//

import UIKit

class StoryTellingViewController: UIViewController {
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var paraghraph1Label: UILabel!
    @IBOutlet weak var paragraph2Label: UILabel!
    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var paragraph13Label: UILabel!
    @IBOutlet weak var paragraph14Label: UILabel!
    @IBOutlet weak var paragraph15Label: UILabel!

    @IBOutlet weak var paragraph16Label: UILabel!
    @IBOutlet weak var paragraph17Label: UILabel!
    @IBOutlet weak var paragraph18Label: UILabel!
    @IBOutlet weak var paragraph19Label: UILabel!
    
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var paragraph21Label: UILabel!
    @IBOutlet weak var title21Label: UILabel!
    @IBOutlet weak var paragraph22Label: UILabel!
    @IBOutlet weak var title22Label: UILabel!
    @IBOutlet weak var paragraph23Label: UILabel!
    
    @IBOutlet weak var paragraph24: UILabel!
    @IBOutlet weak var paragraph25: UILabel!
    @IBOutlet weak var paragraph26: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title1Label.text = "OVERVIEW OF INTERNATIONAL STUDENTS IN AUSTRALIA"
        paraghraph1Label.text = "This section of the W-Care mobile application is going to present you information about the trend of international students in Australia with regards to the student count, the most common students’ nationality and also the number of enrolments and commencements of the students across the years in Australia. Note that International students can be classified as Higher Education, ELICOS, Non-Award, Schools as VET."
        paragraph2Label.text = "According to the Australian, the international education sector contributed $5.3 billion to the economy in the March quarter of 2016 because the major increase in international students coming to Australia. The graph below shows how the number of student increases during the past five years, reaching its peak in 2017 (Hare & Hare, 2017)."
        
        paragraph13Label.text = "Before going deeper in the analysis of international students in Australia, we will first explain the two common terms employed for international students which is enrolments and commencements. So, what are these terms?"
        
        paragraph14Label.text = "Enrolments show what courses international students are studying across Australia’s different education sectors. There are more enrolments than students since a student can study in more than one course in one calendar year. Commencements are new enrolments which is a subset of all enrolments."
        
        paragraph15Label.text = "The visualisation below shows the line graph to compare between enrolments and commencements. The numbers and the shape of the lines reflects the previous student count graph which shows an increase year 2012 to 2017. The decrease in international students in Australia between 2010 and 2012 was mostly because of stricter visa conditions and also competition from the United States and Europe (Lost international student enrolments may cost Australia billions, 2017)."
        
        paragraph16Label.text = "Now, we will have a deeper look about the enrolments and commencements for the different states in Australia."
        paragraph17Label.text = "The graph below shows the enrolments for each state in Australia, and New South Wales shows the highest number of enrolments followed by Victoria."
        paragraph18Label.text = "The graph below shows the enrolments for each state in Australia, and New South Wales shows the highest number of enrolments followed by Victoria."
        
        paragraph19Label.text = "As we all know, Australia has welcomed different international students from different countries and hence, we would like to present the top eight countries from where students are coming. The bar chart below shows China as the most popular nationality followed by India and Malaysia."
        
        title2Label.text = "SURVEY INSIGHTS"
        
        paragraph21Label.text = "This section will present you information about a survey conducted by our team, the team Random in order to better understand international students in Australia positions when talking about their jobs. Following the survey, the number of international students who participated was 70 and after analysing the data from the survey we came up with some interesting insights which are as follows:"
        
        title21Label.text = "Knowledge of international students about Woking conditions and Rights in Australia:"
        
        paragraph22Label.text = "Among the 70 international students who responded, 39 responded that they are currently working or worked previously in Australia whether as casual or part time. For us to determine their knowledge about the working rights and conditions in Australia, a ladder from 1 to 5 was presented to them where they could rate their knowledge about the working rights and conditions in Australia (5 is high knowledge). The average rating for all the 70 students was 2.95/5; the average rating for 39 international students already who have working experience in Australia was 3.05/5; for those with no work experience in Australia the average rating was 2.83/5."
        
        title22Label.text = "International Students’ opinions about been treated fairly at their work place:"
        
        paragraph23Label.text = "The survey also helped to know whether the international students who responded to the survey had previously experienced something which was unfair. The result was categorised as Yes they were treated unfairly, Maybe they were treated unfairly or No they were treated fairly and equally. The result shows that among the 39 international students working whether as casual or part time, 18 responded as Yes they were treated unfairly, 13 responded as No they were treated fairly and equally and 8 responded as Maybe they were treated unfairly."
        
        paragraph24.text = "References:"
        paragraph25.text = "Hare, J., & Hare, J. (2017). Overseas students worth $19.7bn. Theaustralian.com.au. Retrieved 15 September 2017, from http://www.theaustralian.com.au/higher-education/overseas-students-contribute-record197bn-to-economy/news-story/23674f2625f0e5da5eb0892145d92290"
        paragraph26.text = "Lost international student enrolments may cost Australia billions. (2017). The Conversation. Retrieved 15 September 2017, from https://theconversation.com/lost-international-student-enrolments-may-cost-australia-billions-2199"
        
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

}
